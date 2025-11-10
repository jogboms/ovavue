import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetUseCase', () {
    final analytics = LogAnalytics();
    final useCase = UpdateBudgetUseCase(
      budgets: mockRepositories.budgets,
      analytics: analytics,
    );

    final dummyData = UpdateBudgetData(
      id: 'id',
      path: 'path',
      title: 'title',
      description: 'description',
      amount: 1,
      active: true,
      startedAt: clock.now(),
      endedAt: clock.now(),
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget budget', () async {
      when(() => mockRepositories.budgets.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudget('path')));
    });

    test('should bubble update errors', () {
      when(() => mockRepositories.budgets.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
