import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_data.dart';

class CreateBudgetUseCase {
  const CreateBudgetUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetData budget,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudget(userId)));
    throw UnimplementedError();
  }
}
