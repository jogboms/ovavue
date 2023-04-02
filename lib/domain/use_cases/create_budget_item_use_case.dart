import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_item_data.dart';

class CreateBudgetItemUseCase {
  const CreateBudgetItemUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetItemData item,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetItem(userId)));
    throw UnimplementedError();
  }
}
