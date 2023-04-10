import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsByPlanUseCase', () {
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final FetchBudgetAllocationsByPlanUseCase useCase = FetchBudgetAllocationsByPlanUseCase(
      allocations: budgetAllocationsRepository,
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
      categories: budgetCategoriesRepository,
    );

    tearDown(() {
      reset(budgetAllocationsRepository);
      reset(budgetsRepository);
      reset(budgetPlansRepository);
      reset(budgetCategoriesRepository);
    });

    test('should fetch budget allocations by plan', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntity plan = BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first);
      final NormalizedBudgetEntity budget = BudgetsMockImpl.generateNormalizedBudget(
        plans: <NormalizedBudgetPlanEntity>[plan],
      );
      final NormalizedBudgetAllocationEntityList expectedAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget, plan: plan)
      ];

      when(() => budgetAllocationsRepository.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.asBudgetAllocationEntityList.sublist(1)),
      );
      when(() => budgetsRepository.fetch('1'))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(<BudgetEntity>[budget.asBudgetEntity]));
      when(() => budgetPlansRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(<BudgetPlanEntity>[plan.asBudgetPlanEntity]));
      when(() => budgetCategoriesRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase(userId: '1', planId: '1'), emits(expectedAllocations.sublist(1)));
    });

    test('should bubble fetch errors', () {
      when(() => budgetAllocationsRepository.fetchByPlan(userId: '1', planId: '1')).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', planId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetAllocationsRepository.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.error(expectedError),
      );
      when(() => budgetsRepository.fetch('1')).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => budgetCategoriesRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', planId: '1'), emitsError(expectedError));
    });
  });
}
