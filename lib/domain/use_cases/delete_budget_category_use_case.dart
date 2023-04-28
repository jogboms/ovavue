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

  Future<bool> call({
    required String id,
    required String path,
  }) {
    _analytics.log(AnalyticsEvent.deleteBudgetCategory(path)).ignore();
    return _categories.delete(id: id, path: path);
  }
}
