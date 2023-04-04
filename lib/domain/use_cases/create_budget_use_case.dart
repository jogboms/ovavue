import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_data.dart';
import '../repositories/budgets.dart';

class CreateBudgetUseCase {
  const CreateBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  })  : _budgets = budgets,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetData budget,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudget(userId)));
    throw UnimplementedError();
  }
}
