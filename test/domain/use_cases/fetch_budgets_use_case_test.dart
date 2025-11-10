import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetsUseCase', () {
    final useCase = FetchBudgetsUseCase(budgets: mockRepositories.budgets);

    tearDown(mockRepositories.reset);

    test('should fetch budgets', () {
      final expectedBudgets = <BudgetEntity>[BudgetsMockImpl.generateBudget()];

      when(
        () => mockRepositories.budgets.fetchAll(any()),
      ).thenAnswer((_) => Stream<BudgetEntityList>.value(expectedBudgets));

      expectLater(useCase('1'), emits(expectedBudgets));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgets.fetchAll('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgets.fetchAll(any())).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
