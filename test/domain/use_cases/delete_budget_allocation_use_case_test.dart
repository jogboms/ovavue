import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final DeleteBudgetAllocationUseCase useCase = DeleteBudgetAllocationUseCase(
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    tearDown(() {
      analytics.reset();
      reset(budgetAllocationsRepository);
    });

    test('should delete a budget allocation', () async {
      when(() => budgetAllocationsRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase('path'), completion(true));
      expect(
        analytics.events,
        <AnalyticsEvent>[
          AnalyticsEvent.deleteBudgetAllocation('path'),
        ],
      );
    });

    test('should bubble delete errors', () {
      when(() => budgetAllocationsRepository.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase('path'), throwsException);
    });
  });
}
