import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetCategoryUseCase useCase = CreateBudgetCategoryUseCase(
      categories: mockRepositories.budgetCategories,
      analytics: analytics,
    );

    final BudgetCategoryEntity dummyEntity = BudgetCategoriesMockImpl.generateCategory(userId: '1');
    const CreateBudgetCategoryData dummyData = CreateBudgetCategoryData(
      title: 'title',
      description: 'description',
      icon: 0,
      color: 0,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget category', () async {
      when(() => mockRepositories.budgetCategories.create(any(), any())).thenAnswer((_) async => dummyEntity.id);

      await expectLater(useCase(userId: '1', category: dummyData), completion(dummyEntity.id));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetCategory('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgetCategories.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', category: dummyData), throwsException);
    });
  });
}
