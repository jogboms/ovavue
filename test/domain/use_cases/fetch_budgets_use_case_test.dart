import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetsUseCase', () {
    final FetchBudgetsUseCase useCase = FetchBudgetsUseCase(budgets: mockRepositories.budgets);

    tearDown(mockRepositories.reset);

    test('should fetch budgets', () {
      final NormalizedBudgetEntityList expectedBudgets = <NormalizedBudgetEntity>[
        BudgetsMockImpl.generateNormalizedBudget()
      ];

      when(() => mockRepositories.budgets.fetch(any()))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(expectedBudgets.asBudgetEntityList));

      expectLater(useCase('1'), emits(expectedBudgets));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgets.fetch('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgets.fetch(any())).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
