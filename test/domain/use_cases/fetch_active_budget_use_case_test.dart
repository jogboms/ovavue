import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchActiveBudgetUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchActiveBudgetUseCase useCase = FetchActiveBudgetUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch active budget', () {
      final BudgetPlanEntityList plans = <BudgetPlanEntity>[BudgetPlansMockImpl.generatePlan()];
      final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget(plans: plans);

      when(() => budgetsRepository.fetchActiveBudget(any()))
          .thenAnswer((_) => Stream<BudgetEntity>.value(expectedBudget.asBudgetEntity));
      when(() => budgetPlansRepository.fetch(any())).thenAnswer((_) => Stream<BudgetPlanEntityList>.value(plans));

      expectLater(useCase('1'), emits(expectedBudget));
    });

    test('should bubble fetch errors', () {
      when(() => budgetsRepository.fetchActiveBudget('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetsRepository.fetchActiveBudget(any())).thenAnswer(
        (_) => Stream<BudgetEntity>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
