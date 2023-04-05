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

    test('should delete a budget', () async {
      when(() => budgetsRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase('path'), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudget('path')));
    });

    test('should bubble delete errors', () {
      when(() => budgetsRepository.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase('path'), throwsException);
    });
  });
}
