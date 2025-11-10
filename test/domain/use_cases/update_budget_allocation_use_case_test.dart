import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetAllocationUseCase', () {
    final analytics = LogAnalytics();
    final useCase = UpdateBudgetAllocationUseCase(
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    const dummyData = UpdateBudgetAllocationData(
      id: 'id',
      path: 'path',
      amount: 1,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget allocation', () async {
      when(() => mockRepositories.budgetAllocations.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudgetAllocation('path')));
    });

    test('should bubble update errors', () {
      when(() => mockRepositories.budgetAllocations.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
