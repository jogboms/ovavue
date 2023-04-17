import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final UpdateBudgetPlanUseCase useCase = UpdateBudgetPlanUseCase(plans: budgetPlansRepository, analytics: analytics);

    const UpdateBudgetPlanData dummyData = UpdateBudgetPlanData(
      id: 'id',
      path: 'path',
      title: 'title',
      description: 'description',
      categoryId: 'id',
      categoryPath: 'path',
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetPlansRepository);
    });

    test('should create a budget plan', () async {
      when(() => budgetPlansRepository.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudgetPlan('path')));
    });

    test('should bubble update errors', () {
      when(() => budgetPlansRepository.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
