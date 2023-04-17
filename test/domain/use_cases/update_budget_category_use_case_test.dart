import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final UpdateBudgetCategoryUseCase useCase = UpdateBudgetCategoryUseCase(
      categories: budgetCategoriesRepository,
      analytics: analytics,
    );

    const UpdateBudgetCategoryData dummyData = UpdateBudgetCategoryData(
      id: 'id',
      path: 'path',
      title: 'title',
      description: 'description',
      icon: 1,
      color: 1,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      reset(budgetCategoriesRepository);
    });

    test('should create a budget category', () async {
      when(() => budgetCategoriesRepository.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudgetCategory('path')));
    });

    test('should bubble update errors', () {
      when(() => budgetCategoriesRepository.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
