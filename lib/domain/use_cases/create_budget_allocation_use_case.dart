import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_allocation_data.dart';

class CreateBudgetAllocationUseCase {
  const CreateBudgetAllocationUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Stream<String> call({
    required String userId,
    required CreateBudgetAllocationData allocation,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetAllocation(userId)));
    throw UnimplementedError();
  }
}
