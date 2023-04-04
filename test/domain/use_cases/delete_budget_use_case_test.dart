import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final DeleteBudgetUseCase useCase = DeleteBudgetUseCase(budgets: budgetsRepository, analytics: analytics);

    tearDown(() {
      analytics.reset();
      reset(budgetsRepository);
    });

    test('should delete a budget', () {
      expect(() => useCase('path'), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble delete errors', () {
      expect(() => useCase('path'), throwsUnimplementedError);
    });
  });
}
