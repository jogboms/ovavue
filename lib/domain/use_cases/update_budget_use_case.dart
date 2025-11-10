import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/update_budget_data.dart';
import 'package:ovavue/domain/repositories/budgets.dart';

class UpdateBudgetUseCase {
  const UpdateBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  }) : _budgets = budgets,
       _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<bool> call(UpdateBudgetData budget) {
    _analytics.log(AnalyticsEvent.updateBudget(budget.path)).ignore();
    return _budgets.update(budget);
  }
}
