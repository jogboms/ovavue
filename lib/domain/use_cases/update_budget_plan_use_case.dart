import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/update_budget_plan_data.dart';
import 'package:ovavue/domain/repositories/budget_plans.dart';

class UpdateBudgetPlanUseCase {
  const UpdateBudgetPlanUseCase({
    required BudgetPlansRepository plans,
    required Analytics analytics,
  }) : _plans = plans,
       _analytics = analytics;

  final BudgetPlansRepository _plans;
  final Analytics _analytics;

  Future<bool> call(UpdateBudgetPlanData plan) {
    _analytics.log(AnalyticsEvent.updateBudgetPlan(plan.path)).ignore();
    return _plans.update(plan);
  }
}
