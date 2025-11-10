import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/create_budget_category_data.dart';
import 'package:ovavue/domain/repositories/budget_categories.dart';

class CreateBudgetCategoryUseCase {
  const CreateBudgetCategoryUseCase({
    required BudgetCategoriesRepository categories,
    required Analytics analytics,
  }) : _categories = categories,
       _analytics = analytics;

  final BudgetCategoriesRepository _categories;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetCategoryData category,
  }) {
    _analytics.log(AnalyticsEvent.createBudgetCategory(userId)).ignore();
    return _categories.create(userId, category);
  }
}
