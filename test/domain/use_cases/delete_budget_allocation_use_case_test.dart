import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetAllocationUseCase useCase = DeleteBudgetAllocationUseCase(
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    setUpAll(() {
      registerFallbackValue(const ReferenceEntity(id: '1', path: 'path'));
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget allocation', () async {
      when(() => mockRepositories.budgetAllocations.delete(id: any(named: 'id'), path: any(named: 'path')))
          .thenAnswer((_) async => true);

      await expectLater(useCase(id: '1', path: 'path'), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetAllocation('path')));
    });

    test('should bubble delete errors', () {
      when(() => mockRepositories.budgetAllocations.delete(id: any(named: 'id'), path: any(named: 'path')))
          .thenThrow(Exception('an error'));

      expect(() => useCase(id: '1', path: 'path'), throwsException);
    });
  });
}
