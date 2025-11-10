import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetPlansUseCase', () {
    final useCase = FetchBudgetPlansUseCase(
      plans: mockRepositories.budgetPlans,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget plans', () {
      final category = BudgetCategoriesMockImpl.generateCategory();
      final expectedPlans = [
        BudgetPlansMockImpl.generatePlan(category: category),
      ];

      when(
        () => mockRepositories.budgetPlans.fetchAll(any()),
      ).thenAnswer((_) => Stream<BudgetPlanEntityList>.value(expectedPlans));

      expectLater(useCase('1'), emits(expectedPlans));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetPlans.fetchAll('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgetPlans.fetchAll(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
