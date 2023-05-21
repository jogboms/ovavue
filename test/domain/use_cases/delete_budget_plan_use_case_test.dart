import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetPlanUseCase useCase = DeleteBudgetPlanUseCase(
      plans: mockRepositories.budgetPlans,
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    setUpAll(() {
      registerFallbackValue((id: '1', path: 'path'));
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget plan and remove budget allocations', () async {
      when(() => mockRepositories.budgetAllocations.deleteByPlan(userId: '1', planId: '1'))
          .thenAnswer((_) async => true);
      when(() => mockRepositories.budgetPlans.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(userId: '1', id: '1', path: 'path'), completion(true));
      verify(() => mockRepositories.budgetAllocations.deleteByPlan(userId: '1', planId: '1')).called(1);
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetPlan('path')));
    });

    test('should not delete budget plan if removing allocations was not successful', () async {
      when(() => mockRepositories.budgetAllocations.deleteByPlan(userId: '1', planId: '1'))
          .thenAnswer((_) async => false);
      when(() => mockRepositories.budgetPlans.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(userId: '1', id: '1', path: 'path'), completion(false));
      verify(() => mockRepositories.budgetAllocations.deleteByPlan(userId: '1', planId: '1')).called(1);
      verifyNever(() => mockRepositories.budgetPlans.delete((id: '1', path: 'path')));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetPlan('path')));
    });

    test('should bubble delete errors', () {
      when(() => mockRepositories.budgetAllocations.deleteByPlan(userId: '1', planId: '1'))
          .thenThrow(Exception('an error'));
      when(() => mockRepositories.budgetPlans.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', id: '1', path: 'path'), throwsException);
    });
  });
}
