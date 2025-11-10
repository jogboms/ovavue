import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetUseCase', () {
    final analytics = LogAnalytics();
    final useCase = DeleteBudgetUseCase(
      budgets: mockRepositories.budgets,
      analytics: analytics,
    );

    setUpAll(() {
      registerFallbackValue((id: '1', path: 'path'));
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget', () async {
      when(() => mockRepositories.budgets.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(id: '1', path: 'path'), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudget('path')));
    });

    test('should bubble delete errors', () {
      when(() => mockRepositories.budgets.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase(id: '1', path: 'path'), throwsException);
    });
  });
}
