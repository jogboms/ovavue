import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_plan_data.dart';

class CreateBudgetPlanUseCase {
  const CreateBudgetPlanUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetPlanData plan,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetPlan(userId)));
    throw UnimplementedError();
  }
}
