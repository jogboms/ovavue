import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsByPlanUseCase', () {
    final useCase = FetchBudgetAllocationsByPlanUseCase(
      allocations: mockRepositories.budgetAllocations,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget allocations by plan', () {
      final categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final plan = BudgetPlansMockImpl.generatePlan(category: categories.first);
      final budget = BudgetsMockImpl.generateBudget();
      final expectedAllocations = <BudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateAllocation(budget: budget, plan: plan),
      ];

      when(() => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations.sublist(1)),
      );

      expectLater(useCase(userId: '1', planId: '1'), emits(expectedAllocations.sublist(1)));
    });

    test('should bubble fetch errors', () {
      when(
        () => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1'),
      ).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', planId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgetAllocations.fetchByPlan(userId: '1', planId: '1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', planId: '1'), emitsError(expectedError));
    });
  });
}
