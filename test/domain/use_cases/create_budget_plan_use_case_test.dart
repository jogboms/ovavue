import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final CreateBudgetPlanUseCase useCase = CreateBudgetPlanUseCase(plans: budgetPlansRepository, analytics: analytics);

    final BudgetPlanEntity dummyEntity = BudgetPlansMockImpl.generatePlan(userId: '1');
    final CreateBudgetPlanData dummyData = CreateBudgetPlanData(
      title: 'title',
      description: 'description',
      category: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetPlansRepository);
    });

    test('should create a budget plan', () async {
      when(() => budgetPlansRepository.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', plan: dummyData), completion(dummyEntity.id));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetPlan('1')));
    });

    test('should bubble create errors', () {
      when(() => budgetPlansRepository.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', plan: dummyData), throwsException);
    });
  });
}
