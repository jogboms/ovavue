import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final CreateBudgetCategoryUseCase useCase = CreateBudgetCategoryUseCase(
      categories: budgetCategoriesRepository,
      analytics: analytics,
    );
    const CreateBudgetCategoryData dummyData = CreateBudgetCategoryData(
      title: 'title',
      description: 'description',
      color: 0,
    );

    tearDown(analytics.reset);

    test('should create a budget category', () {
      expect(() => useCase(userId: '1', category: dummyData), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', category: dummyData), throwsUnimplementedError);
    });
  });
}
