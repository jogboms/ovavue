import 'package:flutter_test/flutter_test.dart';
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

    test('should delete a budget category', () {
      expect(() => useCase('path'), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble delete errors', () {
      expect(() => useCase('path'), throwsUnimplementedError);
    });
  });
}
