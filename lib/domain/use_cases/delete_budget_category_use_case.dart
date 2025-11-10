import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/repositories/budget_categories.dart';

class DeleteBudgetCategoryUseCase {
  const DeleteBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  }) : _categories = categories,
       _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<bool> call(ReferenceEntity reference) {
    _analytics.log(AnalyticsEvent.deleteBudgetCategory(reference.path)).ignore();
    return _categories.delete(reference);
  }
}
