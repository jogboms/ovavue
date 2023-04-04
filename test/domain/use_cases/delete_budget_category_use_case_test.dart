import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final DeleteBudgetCategoryUseCase useCase = DeleteBudgetCategoryUseCase(
      categories: budgetCategoriesRepository,
      analytics: analytics,
    );

    tearDown(analytics.reset);

    test('should delete a budget category', () async {
      when(() => budgetCategoriesRepository.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase('path'), completion(true));
      expect(
        analytics.events,
        <AnalyticsEvent>[
          AnalyticsEvent.deleteBudgetCategory('path'),
        ],
      );
    });

    test('should bubble delete errors', () {
      when(() => budgetCategoriesRepository.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase('path'), throwsException);
    });
  });
}
