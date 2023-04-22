import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetPlanUseCase useCase = DeleteBudgetPlanUseCase(
      budgets: mockRepositories.budgets,
      plans: mockRepositories.budgetPlans,
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget plan', () async {
      when(() => mockRepositories.budgetPlans.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(id: 'id', path: 'path'), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetPlan('path')));
    });

    test('should bubble delete errors', () {
      when(() => mockRepositories.budgetPlans.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase(id: 'id', path: 'path'), throwsException);
    });
  });
}
