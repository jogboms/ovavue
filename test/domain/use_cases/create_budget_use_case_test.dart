import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final CreateBudgetUseCase useCase = CreateBudgetUseCase(budgets: budgetsRepository, analytics: analytics);

    final BudgetEntity dummyEntity = BudgetsMockImpl.generateBudget(userId: '1');
    final CreateBudgetData dummyData = CreateBudgetData(
      title: 'title',
      amount: 1,
      description: 'description',
      plans: <ReferenceEntity>[],
      startedAt: DateTime(0),
      endedAt: null,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetsRepository);
    });

    test('should create a budget', () async {
      when(() => budgetsRepository.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', budget: dummyData), completion(dummyEntity.id));
      expect(
        analytics.events,
        <AnalyticsEvent>[
          AnalyticsEvent.createBudget('1'),
        ],
      );
    });

    test('should bubble create errors', () {
      when(() => budgetsRepository.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budget: dummyData), throwsException);
    });
  });
}
