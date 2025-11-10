import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchActiveBudgetUseCase', () {
    final useCase = FetchActiveBudgetUseCase(budgets: mockRepositories.budgets);

    tearDown(mockRepositories.reset);

    test('should fetch active budget', () {
      final expectedBudget = BudgetsMockImpl.generateBudget();

      when(
        () => mockRepositories.budgets.fetchActiveBudget(any()),
      ).thenAnswer((_) => Stream<BudgetEntity>.value(expectedBudget));

      expectLater(useCase('1'), emits(expectedBudget));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgets.fetchActiveBudget('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgets.fetchActiveBudget(any())).thenAnswer(
        (_) => Stream<BudgetEntity>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
