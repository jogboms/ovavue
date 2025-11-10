import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/update_budget_category_data.dart';
import 'package:ovavue/domain/repositories/budget_categories.dart';

class UpdateBudgetCategoryUseCase {
  const UpdateBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  }) : _categories = categories,
       _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<bool> call(UpdateBudgetCategoryData category) {
    _analytics.log(AnalyticsEvent.updateBudgetCategory(category.path)).ignore();
    return _categories.update(category);
  }
}
