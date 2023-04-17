import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final CreateBudgetAllocationUseCase useCase = CreateBudgetAllocationUseCase(
      budgets: budgetsRepository,
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    final BudgetAllocationEntity dummyEntity = BudgetAllocationsMockImpl.generateAllocation(userId: '1');
    const CreateBudgetAllocationData dummyData = CreateBudgetAllocationData(
      amount: 1,
      budget: ReferenceEntity(id: '1', path: 'path'),
      plan: ReferenceEntity(id: '1', path: 'path'),
    );

    setUpAll(() {
      registerFallbackValue(dummyData.budget);
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget allocation and add plan to budget', () async {
      when(
        () => budgetsRepository.addPlan(
          userId: any(named: 'userId'),
          budgetId: any(named: 'budgetId'),
          plan: any(named: 'plan'),
        ),
      ).thenAnswer((_) async => true);
      when(() => budgetAllocationsRepository.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', allocation: dummyData), completion(dummyEntity.id));
      verify(() => budgetsRepository.addPlan(userId: '1', budgetId: '1', plan: dummyData.plan)).called(1);
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetAllocation('1')));
    });

    test('should bubble create errors', () {
      when(() => budgetAllocationsRepository.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', allocation: dummyData), throwsException);
    });
  });
}
