import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsByPlanUseCase', () {
    final FetchBudgetAllocationsByPlanUseCase useCase = FetchBudgetAllocationsByPlanUseCase(
      allocations: mockRepositories.budgetAllocations,
      budgets: mockRepositories.budgets,
      plans: mockRepositories.budgetPlans,
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget allocations by plan', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntity plan = BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first);
      final NormalizedBudgetEntity budget = BudgetsMockImpl.generateNormalizedBudget();
      final NormalizedBudgetAllocationEntityList expectedAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget, plan: plan)
      ];

      when(() => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.asBudgetAllocationEntityList.sublist(1)),
      );
      when(() => mockRepositories.budgets.fetch('1'))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(<BudgetEntity>[budget.asBudgetEntity]));
      when(() => mockRepositories.budgetPlans.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(<BudgetPlanEntity>[plan.asBudgetPlanEntity]));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase(userId: '1', planId: '1'), emits(expectedAllocations.sublist(1)));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1'))
          .thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', planId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
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

      expect(useCase(userId: '1', planId: '1'), emitsError(expectedError));
    });
  });
}
