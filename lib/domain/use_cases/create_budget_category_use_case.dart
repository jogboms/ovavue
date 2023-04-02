import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_category_data.dart';

class CreateBudgetCategoryUseCase {
  const CreateBudgetCategoryUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Stream<String> call({
    required String userId,
    required CreateBudgetCategoryData category,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetCategory(userId)));
    throw UnimplementedError();
  }
}
