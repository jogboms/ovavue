import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsByBudgetUseCase', () {
    final FetchBudgetAllocationsByBudgetUseCase useCase = FetchBudgetAllocationsByBudgetUseCase(
      allocations: mockRepositories.budgetAllocations,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget allocations', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final BudgetPlanEntity plan = BudgetPlansMockImpl.generatePlan(category: categories.first);
      final BudgetEntity budget = BudgetsMockImpl.generateBudget();
      final BudgetAllocationEntityList expectedAllocations = <BudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateAllocation(budget: budget, plan: plan)
      ];

      when(() => mockRepositories.budgetAllocations.fetchByBudget(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.sublist(1)),
      );

      expectLater(useCase(userId: '1', budgetId: '1'), emits(expectedAllocations.sublist(1)));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetAllocations.fetchByBudget(userId: '1', budgetId: '1'))
          .thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budgetId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetAllocations.fetchByBudget(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', budgetId: '1'), emitsError(expectedError));
    });
  });
}
