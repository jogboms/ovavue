import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationUseCase', () {
    final FetchBudgetAllocationUseCase useCase = FetchBudgetAllocationUseCase(
      allocations: mockRepositories.budgetAllocations,
      budgets: mockRepositories.budgets,
      plans: mockRepositories.budgetPlans,
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget allocation for plan', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntity plan = BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first);
      final NormalizedBudgetEntity budget = BudgetsMockImpl.generateNormalizedBudget();
      final NormalizedBudgetAllocationEntity expectedAllocation =
          BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget, plan: plan);

      when(() => mockRepositories.budgetAllocations.fetchOne(userId: '1', budgetId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntity>.value(expectedAllocation.asBudgetAllocationEntity),
      );
      when(() => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1'))
          .thenAnswer((_) => Stream<BudgetEntity>.value(budget.asBudgetEntity));
      when(() => mockRepositories.budgetPlans.fetchOne(userId: '1', planId: '1'))
          .thenAnswer((_) => Stream<BudgetPlanEntity>.value(plan.asBudgetPlanEntity));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase(userId: '1', budgetId: '1', planId: '1'), emits(expectedAllocation));
    });

    test('should emit null when no budget allocation for plan', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntity plan = BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first);
      final NormalizedBudgetEntity budget = BudgetsMockImpl.generateNormalizedBudget();

      when(() => mockRepositories.budgetAllocations.fetchOne(userId: '1', budgetId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntity?>.value(null),
      );
      when(() => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1'))
          .thenAnswer((_) => Stream<BudgetEntity>.value(budget.asBudgetEntity));
      when(() => mockRepositories.budgetPlans.fetchOne(userId: '1', planId: '1'))
          .thenAnswer((_) => Stream<BudgetPlanEntity>.value(plan.asBudgetPlanEntity));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase(userId: '1', budgetId: '1', planId: '1'), emits(null));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetAllocations.fetchOne(userId: '1', budgetId: '1', planId: '1'))
          .thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budgetId: '1', planId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetAllocations.fetchOne(userId: '1', budgetId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntity>.error(expectedError),
      );
      when(() => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetEntity>.error(expectedError),
      );
      when(() => mockRepositories.budgetPlans.fetchOne(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetPlanEntity>.error(expectedError),
      );
      when(() => mockRepositories.budgetCategories.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', budgetId: '1', planId: '1'), emitsError(expectedError));
    });
  });
}
