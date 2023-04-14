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

  tearDown(mockUseCases.reset);

  group('SelectedBudgetCategoryByBudgetProvider', () {
    Future<BudgetCategoryByBudgetState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
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
      final List<NormalizedBudgetPlanEntity> plans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: expectedCategory),
      ];
      final NormalizedBudgetEntity expectedBudget =
          BudgetsMockImpl.generateNormalizedBudget(id: budgetId, plans: plans);
      final List<NormalizedBudgetAllocationEntity> expectedBudgetAllocations =
          List<NormalizedBudgetAllocationEntity>.filled(
        3,
        BudgetAllocationsMockImpl.generateNormalizedAllocation(
          budget: expectedBudget,
          plan: expectedBudget.plans.first,
        ),
      );

      when(() => mockUseCases.fetchBudgetUseCase.call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')))
          .thenAnswer((_) => Stream<NormalizedBudgetEntity>.value(expectedBudget));
      when(
        () => mockUseCases.fetchBudgetPlansByCategoryUseCase
            .call(userId: any(named: 'userId'), categoryId: any(named: 'categoryId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetPlanEntityList>.value(plans));
      when(
        () => mockUseCases.fetchBudgetAllocationsUseCase
            .call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetAllocationEntityList>.value(expectedBudgetAllocations));

      expect(
        createProviderStream(),
        completion(
          BudgetCategoryByBudgetState(
            budget: BudgetCategoryBudgetViewModel(
              id: expectedBudget.id,
              path: expectedBudget.path,
              amount: expectedBudget.amount.asMoney,
            ),
            plans: plans
                .map(
                  (NormalizedBudgetPlanEntity plan) => BudgetCategoryPlanViewModel(
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
