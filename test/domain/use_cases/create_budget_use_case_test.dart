import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final CreateBudgetUseCase useCase = CreateBudgetUseCase(budgets: budgetsRepository, analytics: analytics);
    final CreateBudgetData dummyData = CreateBudgetData(
      title: 'title',
      amount: 1,
      description: 'description',
      plans: <ReferenceEntity>[],
      startedAt: DateTime(0),
      endedAt: null,
    );

    tearDown(() {
      analytics.reset();
      reset(budgetsRepository);
    });

    test('should create a budget', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
    });
  });
}
