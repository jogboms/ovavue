import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetUseCase', () {
    final useCase = FetchBudgetUseCase(budgets: mockRepositories.budgets);

    tearDown(mockRepositories.reset);

    test('should fetch budget', () {
      final expectedBudget = BudgetsMockImpl.generateBudget();

      when(
        () => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1'),
      ).thenAnswer((_) => Stream<BudgetEntity>.value(expectedBudget));

      expectLater(useCase(userId: '1', budgetId: '1'), emits(expectedBudget));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1')).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budgetId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgets.fetchOne(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetEntity>.error(expectedError),
      );

      expect(useCase(userId: '1', budgetId: '1'), emitsError(expectedError));
    });
  });
}
