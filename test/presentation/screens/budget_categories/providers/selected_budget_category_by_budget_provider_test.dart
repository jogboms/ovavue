import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final dummyUser = UsersMockImpl.user;
  const categoryId = 'category-id';
  const budgetId = 'budget-id';

  final expectedCategory = BudgetCategoriesMockImpl.generateCategory(id: categoryId);
  final expectedPlan = BudgetPlansMockImpl.generatePlan(
    category: expectedCategory,
  );
  final expectedPlans = <BudgetPlanEntity>[expectedPlan];
  final expectedBudget = BudgetsMockImpl.generateBudget(id: budgetId);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetCategoryByBudgetProvider', () {
    Future<BudgetCategoryState> createProviderStream() {
      final container = createProviderContainer(
        overrides: [
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
      final expectedBudgetAllocations = List<BudgetAllocationEntity>.filled(
        3,
        BudgetAllocationsMockImpl.generateAllocation(
          budget: expectedBudget,
          plan: expectedPlans.first,
        ),
      );

      when(
        () => mockUseCases.fetchBudgetAllocationsByBudgetUseCase.call(
          userId: any(named: 'userId'),
          budgetId: any(named: 'budgetId'),
        ),
      ).thenAnswer((_) => Stream<BudgetAllocationEntityList>.value(expectedBudgetAllocations));

      expect(
        createProviderStream(),
        completion(
          BudgetCategoryState(
            budget: BudgetViewModel.fromEntity(expectedBudget),
            plans: expectedPlans
                .map(
                  (BudgetPlanEntity plan) => (
                    BudgetPlanViewModel.fromEntity(plan),
                    expectedBudgetAllocations
                        .firstWhere(
                          (BudgetAllocationEntity e) => e.plan.id == plan.id && e.budget.id == expectedBudget.id,
                        )
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
