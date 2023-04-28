import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetPlansByBudgetUseCase', () {
    final FetchBudgetPlansByBudgetUseCase useCase = FetchBudgetPlansByBudgetUseCase(
      allocations: mockRepositories.budgetAllocations,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget plans by budget', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final BudgetPlanEntityList plans = <BudgetPlanEntity>[
        BudgetPlansMockImpl.generatePlan(category: categories.first),
        BudgetPlansMockImpl.generatePlan(category: categories.first),
        BudgetPlansMockImpl.generatePlan(category: categories.first),
        BudgetPlansMockImpl.generatePlan(category: categories.first),
      ];
      final BudgetEntity budget1 = BudgetsMockImpl.generateBudget();
      final BudgetEntity budget2 = BudgetsMockImpl.generateBudget();
      final BudgetAllocationEntityList expectedAllocations = <BudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateAllocation(budget: budget1, plan: plans[0]),
        BudgetAllocationsMockImpl.generateAllocation(budget: budget1, plan: plans[1]),
        BudgetAllocationsMockImpl.generateAllocation(budget: budget1, plan: plans[2]),
        BudgetAllocationsMockImpl.generateAllocation(budget: budget1, plan: plans[3]),
        BudgetAllocationsMockImpl.generateAllocation(budget: budget2, plan: plans[0]),
        BudgetAllocationsMockImpl.generateAllocation(budget: budget2, plan: plans[1]),
      ];

      when(() => mockRepositories.budgetAllocations.fetchAll('1')).thenAnswer(
        (_) => Stream<BudgetAllocationEntityList>.value(expectedAllocations),
      );

      expectLater(
        useCase('1'),
        emits(<String, Set<BudgetPlanEntity>>{
          budget1.id: <BudgetPlanEntity>{...plans},
          budget2.id: <BudgetPlanEntity>{...plans.sublist(0, 2)},
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

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
