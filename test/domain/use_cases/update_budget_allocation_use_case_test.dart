import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final UpdateBudgetAllocationUseCase useCase = UpdateBudgetAllocationUseCase(
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    const UpdateBudgetAllocationData dummyData = UpdateBudgetAllocationData(
      id: 'id',
      path: 'path',
      amount: 1,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetAllocationsRepository);
    });

    test('should create a budget allocation', () async {
      when(() => budgetAllocationsRepository.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudgetAllocation('path')));
    });

    test('should bubble update errors', () {
      when(() => budgetAllocationsRepository.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
