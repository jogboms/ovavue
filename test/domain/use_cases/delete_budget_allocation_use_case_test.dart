import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final DeleteBudgetAllocationUseCase useCase = DeleteBudgetAllocationUseCase(
      budgets: budgetsRepository,
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    setUpAll(() {
      registerFallbackValue(const ReferenceEntity(id: '1', path: 'path'));
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget allocation and remove budget plan', () async {
      when(() => budgetsRepository.removePlan(path: any(named: 'path'), planId: any(named: 'planId')))
          .thenAnswer((_) async => true);
      when(() => budgetAllocationsRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(budgetPath: 'path', planId: '1', path: 'path'), completion(true));
      verify(() => budgetsRepository.removePlan(path: 'path', planId: '1')).called(1);
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetAllocation('path')));
    });

    test('should not delete budget allocation if removing plan was not successful', () async {
      when(() => budgetsRepository.removePlan(path: any(named: 'path'), planId: any(named: 'planId')))
          .thenAnswer((_) async => false);
      when(() => budgetAllocationsRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase(budgetPath: 'path', planId: '1', path: 'path'), completion(false));
      verify(() => budgetsRepository.removePlan(path: 'path', planId: '1')).called(1);
      verifyNever(() => budgetAllocationsRepository.delete('path'));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetAllocation('path')));
    });

    test('should bubble delete errors', () {
      when(() => budgetsRepository.removePlan(path: any(named: 'path'), planId: any(named: 'planId')))
          .thenAnswer((_) async => true);
      when(() => budgetAllocationsRepository.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase(budgetPath: 'path', planId: '1', path: 'path'), throwsException);
    });
  });
}
