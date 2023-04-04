import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_plan_data.dart';
import '../repositories/budget_plans.dart';

class CreateBudgetPlanUseCase {
  const CreateBudgetPlanUseCase({
    required BudgetPlansRepository plans,
    required Analytics analytics,
  })  : _plans = plans,
        _analytics = analytics;

  final BudgetPlansRepository _plans;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetPlanData plan,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetPlan(userId)));
    return _plans.create(userId, plan);
  }
}
