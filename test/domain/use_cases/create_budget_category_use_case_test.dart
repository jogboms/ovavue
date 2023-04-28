import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetCategoryUseCase useCase = CreateBudgetCategoryUseCase(
      categories: mockRepositories.budgetCategories,
      analytics: analytics,
    );

    const CreateBudgetCategoryData dummyData = CreateBudgetCategoryData(
      title: 'title',
      description: 'description',
      iconIndex: 0,
      colorSchemeIndex: 0,
    );

    setUpAll(() {
      registerFallbackValue(dummyData);
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should create a budget category', () async {
      when(() => mockRepositories.budgetCategories.create(any(), any())).thenAnswer((_) async => '1');

      await expectLater(useCase(userId: '1', category: dummyData), completion('1'));
      expect(analytics.events, containsOnce(AnalyticsEvent.createBudgetCategory('1')));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.budgetCategories.create(any(), any())).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', category: dummyData), throwsException);
    });
  });
}
