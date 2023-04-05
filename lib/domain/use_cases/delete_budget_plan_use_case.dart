import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_plans.dart';

class DeleteBudgetPlanUseCase {
  const DeleteBudgetPlanUseCase({
    required BudgetPlansRepository plans,
    required Analytics analytics,
  })  : _plans = plans,
        _analytics = analytics;

  final BudgetPlansRepository _plans;
  final Analytics _analytics;

  Future<bool> call(String path) {
    _analytics.log(AnalyticsEvent.deleteBudgetPlan(path)).ignore();
    return _plans.delete(path);
  }
}
