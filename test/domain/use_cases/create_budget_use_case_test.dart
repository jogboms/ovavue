import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetUseCase useCase = CreateBudgetUseCase(
      budgets: mockRepositories.budgets,
      analytics: analytics,
    );

    final BudgetEntity dummyEntity = BudgetsMockImpl.generateBudget(userId: '1');
    final CreateBudgetData dummyData = CreateBudgetData(
      title: 'title',
      amount: 1,
      description: 'description',
      startedAt: DateTime(0),
      endedAt: null,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget', () async {
      when(() => mockRepositories.budgets.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', budget: dummyData), completion(dummyEntity.id));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudget('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgets.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budget: dummyData), throwsException);
    });
  });
}
