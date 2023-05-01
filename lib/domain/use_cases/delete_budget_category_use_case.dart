import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/reference_entity.dart';
import '../repositories/budget_categories.dart';

class DeleteBudgetCategoryUseCase {
  const DeleteBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  })  : _categories = categories,
        _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<bool> call(ReferenceEntity reference) {
    _analytics.log(AnalyticsEvent.deleteBudgetCategory(reference.path)).ignore();
    return _categories.delete(reference);
  }
}
