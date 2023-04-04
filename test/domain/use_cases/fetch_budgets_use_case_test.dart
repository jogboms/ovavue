import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetsUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchBudgetsUseCase useCase = FetchBudgetsUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch budgets', () {
      final BudgetPlanEntityList plans = <BudgetPlanEntity>[BudgetPlansMockImpl.generatePlan()];
      final NormalizedBudgetEntityList expectedBudgets = <NormalizedBudgetEntity>[
        BudgetsMockImpl.generateNormalizedBudget(plans: plans)
      ];

      when(() => budgetsRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(expectedBudgets.asBudgetEntityList));
      when(() => budgetPlansRepository.fetch(any())).thenAnswer((_) => Stream<BudgetPlanEntityList>.value(plans));

      expectLater(useCase('1'), emits(expectedBudgets));
    });

    test('should bubble fetch errors', () {
      when(() => budgetsRepository.fetch('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetsRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
