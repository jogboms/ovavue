import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_categories.dart';

class DeleteBudgetCategoryUseCase {
  const DeleteBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  })  : _categories = categories,
        _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<bool> call(String path) {
    unawaited(_analytics.log(AnalyticsEvent.deleteBudgetCategory(path)));
    return _categories.delete(path);
  }
}
