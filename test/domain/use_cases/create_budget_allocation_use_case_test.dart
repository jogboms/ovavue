import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final CreateBudgetAllocationUseCase useCase = CreateBudgetAllocationUseCase(
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    final BudgetAllocationEntity dummyEntity = BudgetAllocationsMockImpl.generateAllocation(userId: '1');
    final CreateBudgetAllocationData dummyData = CreateBudgetAllocationData(
      amount: 1,
      budget: const ReferenceEntity(id: '1', path: 'path'),
      plan: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetAllocationsRepository);
    });

    test('should create a budget allocation', () async {
      when(() => budgetAllocationsRepository.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', allocation: dummyData), completion(dummyEntity.id));
      expect(
        analytics.events,
        <AnalyticsEvent>[
          AnalyticsEvent.createBudgetAllocation('1'),
        ],
      );
    });

    test('should bubble create errors', () {
      when(() => budgetAllocationsRepository.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', allocation: dummyData), throwsException);
    });
  });
}
