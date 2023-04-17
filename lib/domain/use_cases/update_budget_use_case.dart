import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/update_budget_data.dart';
import '../repositories/budgets.dart';

class UpdateBudgetUseCase {
  const UpdateBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  })  : _budgets = budgets,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<bool> call(UpdateBudgetData budget) {
    _analytics.log(AnalyticsEvent.updateBudget(budget.path)).ignore();
    return _budgets.update(budget);
  }
}
