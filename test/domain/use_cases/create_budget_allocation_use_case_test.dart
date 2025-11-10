import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetAllocationUseCase', () {
    final analytics = LogAnalytics();
    final useCase = CreateBudgetAllocationUseCase(
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    const dummyData = CreateBudgetAllocationData(
      amount: 1,
      budget: (id: '1', path: 'path'),
      plan: (id: '1', path: 'path'),
    );

    setUpAll(() {
      registerFallbackValue(dummyData.budget);
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget allocation', () async {
      when(() => mockRepositories.budgetAllocations.create(any(), any())).thenAnswer((_) async => '1');

      await expectLater(useCase(userId: '1', allocation: dummyData), completion('1'));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetAllocation('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgetAllocations.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', allocation: dummyData), throwsException);
    });
  });
}
