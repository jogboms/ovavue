import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetPlanUseCase useCase = CreateBudgetPlanUseCase(
      plans: mockRepositories.budgetPlans,
      analytics: analytics,
    );

    const CreateBudgetPlanData dummyData = CreateBudgetPlanData(
      title: 'title',
      description: 'description',
      category: (id: '1', path: 'path'),
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget plan', () async {
      when(() => mockRepositories.budgetPlans.create(any(), any())).thenAnswer((_) async => '1');

      await expectLater(useCase(userId: '1', plan: dummyData), completion('1'));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetPlan('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgetPlans.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', plan: dummyData), throwsException);
    });
  });
}
