import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/create_budget_plan_data.dart';
import 'package:ovavue/domain/repositories/budget_plans.dart';

class CreateBudgetPlanUseCase {
  const CreateBudgetPlanUseCase({
    required BudgetPlansRepository plans,
    required Analytics analytics,
  }) : _plans = plans,
       _analytics = analytics;

  final BudgetPlansRepository _plans;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetPlanData plan,
  }) {
    _analytics.log(AnalyticsEvent.createBudgetPlan(userId)).ignore();
    return _plans.create(userId, plan);
  }
}
