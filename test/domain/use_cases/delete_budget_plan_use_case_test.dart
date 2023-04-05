import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final DeleteBudgetPlanUseCase useCase = DeleteBudgetPlanUseCase(plans: budgetPlansRepository, analytics: analytics);

    tearDown(() {
      analytics.reset();
      reset(budgetPlansRepository);
    });

    test('should delete a budget plan', () async {
      when(() => budgetPlansRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase('path'), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetPlan('path')));
    });

    test('should bubble delete errors', () {
      when(() => budgetPlansRepository.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase('path'), throwsException);
    });
  });
}
