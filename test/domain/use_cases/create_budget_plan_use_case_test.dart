import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final CreateBudgetPlanUseCase useCase = CreateBudgetPlanUseCase(plans: budgetPlansRepository, analytics: analytics);
    final CreateBudgetPlanData dummyData = CreateBudgetPlanData(
      title: 'title',
      description: 'description',
      category: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    tearDown(() {
      analytics.reset();
      reset(budgetPlansRepository);
    });

    test('should create a budget plan', () {
      expect(() => useCase(userId: '1', plan: dummyData), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', plan: dummyData), throwsUnimplementedError);
    });
  });
}
