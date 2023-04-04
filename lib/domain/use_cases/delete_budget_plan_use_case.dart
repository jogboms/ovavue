import 'dart:async';

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
    unawaited(_analytics.log(AnalyticsEvent.deleteBudgetPlan(path)));
    throw UnimplementedError();
  }
}
