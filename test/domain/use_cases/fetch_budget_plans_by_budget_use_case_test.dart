import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetPlansByBudgetUseCase', () {
    final FetchBudgetPlansByBudgetUseCase useCase = FetchBudgetPlansByBudgetUseCase(
      allocations: mockRepositories.budgetAllocations,
      budgets: mockRepositories.budgets,
      plans: mockRepositories.budgetPlans,
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget plans by budget', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntityList plans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first),
        BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first),
      ];
      final NormalizedBudgetEntity budget1 = BudgetsMockImpl.generateNormalizedBudget();
      final NormalizedBudgetEntity budget2 = BudgetsMockImpl.generateNormalizedBudget();
      final NormalizedBudgetAllocationEntityList expectedAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget1, plan: plans[0]),
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget1, plan: plans[1]),
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget2, plan: plans[0]),
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget2, plan: plans[1]),
      ];

      when(() => mockRepositories.budgetAllocations.fetchAll('1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.asBudgetAllocationEntityList),
      );
      when(() => mockRepositories.budgets.fetch('1')).thenAnswer(
        (_) => Stream<BudgetEntityList>.value(<BudgetEntity>[budget1.asBudgetEntity, budget2.asBudgetEntity]),
      );
      when(() => mockRepositories.budgetPlans.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(plans.asBudgetPlanEntityList));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(
        useCase('1'),
        emits(<String, Set<NormalizedBudgetPlanEntity>>{
          budget1.id: <NormalizedBudgetPlanEntity>{...plans},
          budget2.id: <NormalizedBudgetPlanEntity>{...plans},
        }),
      );
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetAllocations.fetchAll('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetAllocations.fetchAll('1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.error(expectedError),
      );
      when(() => mockRepositories.budgets.fetch('1')).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );
      when(() => mockRepositories.budgetPlans.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => mockRepositories.budgetCategories.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
