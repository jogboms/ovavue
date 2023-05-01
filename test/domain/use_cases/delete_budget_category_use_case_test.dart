import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetCategoryUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetCategoryUseCase useCase = DeleteBudgetCategoryUseCase(
      categories: mockRepositories.budgetCategories,
      analytics: analytics,
    );

    setUpAll(() {
      registerFallbackValue((id: '1', path: 'path'));
    });

    tearDown(() {
      analytics.reset();
      mockRepositories.reset();
    });

    test('should delete a budget category', () async {
      when(() => mockRepositories.budgetCategories.delete(any())).thenAnswer((_) async => true);

      await expectLater(useCase((id: '1', path: 'path')), completion(true));
      expect(analytics.events, containsOnce(AnalyticsEvent.deleteBudgetCategory('path')));
    });

    test('should bubble delete errors', () {
      when(() => mockRepositories.budgetCategories.delete(any())).thenThrow(Exception('an error'));

      expect(() => useCase((id: '1', path: 'path')), throwsException);
    });
  });
}
