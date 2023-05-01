import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String categoryId = 'category-id';
  const String budgetId = 'budget-id';

  final BudgetCategoryEntity expectedCategory = BudgetCategoriesMockImpl.generateCategory(id: categoryId);
  final BudgetPlanEntity expectedPlan = BudgetPlansMockImpl.generatePlan(
    category: expectedCategory,
  );
  final List<BudgetPlanEntity> expectedPlans = <BudgetPlanEntity>[expectedPlan];
  final BudgetEntity expectedBudget = BudgetsMockImpl.generateBudget(id: budgetId);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetCategoryByBudgetProvider', () {
    Future<BudgetCategoryState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          budgetsProvider.overrideWith(
            (_) => Stream<List<BudgetViewModel>>.value(
              <BudgetViewModel>[BudgetViewModel.fromEntity(expectedBudget)],
            ),
          ),
          budgetPlansProvider.overrideWith(
            (_) => Stream<List<BudgetPlanViewModel>>.value(
              <BudgetPlanViewModel>[BudgetPlanViewModel.fromEntity(expectedPlan)],
            ),
          ),
          budgetCategoriesProvider.overrideWith(
            (_) => Stream<List<BudgetCategoryViewModel>>.value(
              <BudgetCategoryViewModel>[BudgetCategoryViewModel.fromEntity(expectedCategory)],
            ),
          ),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetCategoryByBudgetProvider(id: categoryId, budgetId: budgetId).future);
    }

    test('should show selected category by id', () async {
      final List<BudgetAllocationEntity> expectedBudgetAllocations = List<BudgetAllocationEntity>.filled(
        3,
        BudgetAllocationsMockImpl.generateAllocation(
          budget: expectedBudget,
          plan: expectedPlans.first,
        ),
      );

      when(
        () => mockUseCases.fetchBudgetAllocationsByBudgetUseCase
            .call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')),
      ).thenAnswer((_) => Stream<BudgetAllocationEntityList>.value(expectedBudgetAllocations));

      expect(
        createProviderStream(),
        completion(
          BudgetCategoryState(
            budget: BudgetViewModel.fromEntity(expectedBudget),
            plans: expectedPlans
                .map(
                  (BudgetPlanEntity plan) => BudgetCategoryPlanViewModel(
                    id: plan.id,
                    path: plan.path,
                    title: plan.title,
                    description: plan.description,
                    allocation: expectedBudgetAllocations
                        .firstWhere((_) => _.plan.id == plan.id && _.budget.id == expectedBudget.id)
                        .amount
                        .asMoney,
                  ),
                )
                .toList(),
            category: BudgetCategoryViewModel.fromEntity(expectedCategory),
            allocation: expectedBudgetAllocations.first.amount.asMoney,
          ),
        ),
      );
    });
  });
}
