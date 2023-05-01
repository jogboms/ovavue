import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetUseCase useCase = CreateBudgetUseCase(
      budgets: mockRepositories.budgets,
      allocations: mockRepositories.budgetAllocations,
      analytics: analytics,
    );

    const ReferenceEntity dummyReference = ReferenceEntity(id: '1', path: 'path');
    final CreateBudgetData dummyData = CreateBudgetData(
      index: 1,
      title: 'title',
      amount: 1,
      description: 'description',
      startedAt: DateTime(0),
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget', () async {
      when(() => mockRepositories.budgets.create(any(), any())).thenAnswer((_) async => dummyReference);

      await expectLater(
        useCase(
          userId: '1',
          budget: dummyData,
          activeBudgetPath: null,
          allocations: null,
        ),
        completion('1'),
      );
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudget('1')));
    });

    test('should create a budget and deactivate active budget', () async {
      when(() => mockRepositories.budgets.create(any(), any())).thenAnswer((_) async => dummyReference);
      when(() => mockRepositories.budgets.deactivateBudget(budgetPath: 'path', endedAt: any(named: 'endedAt')))
          .thenAnswer((_) async => true);

      await expectLater(
        useCase(
          userId: '1',
          budget: dummyData,
          activeBudgetPath: 'path',
          allocations: null,
        ),
        completion('1'),
      );
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudget('1')));
    });

    test('should create a budget and duplicate allocations', () async {
      when(() => mockRepositories.budgets.create(any(), any())).thenAnswer((_) async => dummyReference);
      when(() => mockRepositories.budgetAllocations.createAll('1', any())).thenAnswer((_) async => <String>['1']);

      await expectLater(
        useCase(
          userId: '1',
          budget: dummyData,
          activeBudgetPath: null,
          allocations: <ReferenceEntity, int>{
            const ReferenceEntity(id: '2', path: 'path'): 1,
          },
        ),
        completion('1'),
      );

      verify(
        () => mockRepositories.budgetAllocations.createAll(
          any(),
          <CreateBudgetAllocationData>[
            const CreateBudgetAllocationData(
              amount: 1,
              budget: dummyReference,
              plan: ReferenceEntity(id: '2', path: 'path'),
            )
          ],
        ),
      );
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudget('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgets.create(any(), any())).thenThrow(Exception('an error'));

      expect(
        () => useCase(
          userId: '1',
          activeBudgetPath: 'path',
          allocations: <ReferenceEntity, int>{},
          budget: dummyData,
        ),
        throwsException,
      );
    });
  });
}
