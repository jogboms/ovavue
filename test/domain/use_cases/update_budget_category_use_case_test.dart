import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final UpdateBudgetCategoryUseCase useCase = UpdateBudgetCategoryUseCase(
      categories: mockRepositories.budgetCategories,
      analytics: analytics,
    );

    const UpdateBudgetCategoryData dummyData = UpdateBudgetCategoryData(
      id: 'id',
      path: 'path',
      title: 'title',
      description: 'description',
      iconIndex: 1,
      colorSchemeIndex: 1,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget category', () async {
      when(() => mockRepositories.budgetCategories.update(any())).thenAnswer((_) async => true);

      await expectLater(useCase(dummyData), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.updateBudgetCategory('path')));
    });

    test('should bubble update errors', () {
      when(() => mockRepositories.budgetCategories.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyData), throwsException);
    });
  });
}
