import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('ActivateBudgetUseCase', () {
    final analytics = LogAnalytics();
    final useCase = ActivateBudgetUseCase(
      budgets: mockRepositories.budgets,
      analytics: analytics,
    );

    const dummyReference = (id: '1', path: 'path');

    setUpAll(() {
      registerFallbackValue(dummyReference);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should activate a budget', () async {
      when(() => mockRepositories.budgets.activateBudget(any())).thenAnswer((_) async => true);

      await expectLater(
        useCase(
          userId: '1',
          reference: dummyReference,
          activeBudgetReference: null,
        ),
        completion(true),
      );
      expect(analytics.events, containsOnce(AnalyticsEvent.activateBudget('path')));
    });

    test('should activate a budget and deactivate active budget', () async {
      when(() => mockRepositories.budgets.activateBudget(any())).thenAnswer((_) async => true);
      when(
        () => mockRepositories.budgets.deactivateBudget(reference: (id: '1', path: 'path'), endedAt: null),
      ).thenAnswer((_) async => true);

      await expectLater(
        useCase(
          userId: '1',
          reference: dummyReference,
          activeBudgetReference: (id: '1', path: 'path'),
        ),
        completion(true),
      );
      expect(analytics.events, containsOnce(AnalyticsEvent.activateBudget('path')));
    });

    test('should bubble activate errors', () {
      when(() => mockRepositories.budgets.activateBudget(any())).thenThrow(Exception('an error'));
      when(
        () => mockRepositories.budgets.deactivateBudget(reference: (id: '1', path: 'path'), endedAt: null),
      ).thenThrow(Exception('an error'));

      expect(
        () => useCase(
          userId: '1',
          reference: dummyReference,
          activeBudgetReference: (id: '1', path: 'path'),
        ),
        throwsException,
      );
    });
  });
}
