import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsUseCase', () {
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchBudgetAllocationsUseCase useCase = FetchBudgetAllocationsUseCase(
      allocations: budgetAllocationsRepository,
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetAllocationsRepository);
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch budget allocations', () {
      final BudgetEntity budget = BudgetsMockImpl.generateBudget();
      final BudgetPlanEntity plan = BudgetPlansMockImpl.generatePlan();
      final NormalizedBudgetAllocationEntityList expectedAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(budget: budget, plan: plan)
      ];

      when(() => budgetAllocationsRepository.fetch(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.asBudgetAllocationEntityList),
      );
      when(() => budgetsRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(<BudgetEntity>[budget]));
      when(() => budgetPlansRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(<BudgetPlanEntity>[plan]));

      expectLater(useCase(userId: '1', budgetId: '1'), emits(expectedAllocations));
    });

    test('should bubble fetch errors', () {
      when(() => budgetAllocationsRepository.fetch(userId: '1', budgetId: '1')).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budgetId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetAllocationsRepository.fetch(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.error(expectedError),
      );
      when(() => budgetsRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', budgetId: '1'), emitsError(expectedError));
    });
  });
}
