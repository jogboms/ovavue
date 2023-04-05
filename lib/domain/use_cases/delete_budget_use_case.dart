import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budgets.dart';

class DeleteBudgetUseCase {
  const DeleteBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  })  : _budgets = budgets,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<bool> call(String path) {
    _analytics.log(AnalyticsEvent.deleteBudget(path)).ignore();
    return _budgets.delete(path);
  }
}
