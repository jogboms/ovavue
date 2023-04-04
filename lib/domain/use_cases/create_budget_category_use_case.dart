import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_category_data.dart';
import '../repositories/budget_categories.dart';

class CreateBudgetCategoryUseCase {
  const CreateBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  })  : _categories = categories,
        _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetCategoryData category,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetCategory(userId)));
    throw UnimplementedError();
  }
}
