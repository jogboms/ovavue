import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
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

    final BudgetCategoryEntity dummyEntity = BudgetCategoriesMockImpl.generateCategory(userId: '1');
    const CreateBudgetCategoryData dummyData = CreateBudgetCategoryData(
      title: 'title',
      description: 'description',
      color: 0,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(analytics.reset);

    test('should create a budget category', () async {
      when(() => budgetCategoriesRepository.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', category: dummyData), completion(dummyEntity.id));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetCategory('1')));
    });

    test('should bubble create errors', () {
      when(() => budgetCategoriesRepository.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', category: dummyData), throwsException);
    });
  });
}
