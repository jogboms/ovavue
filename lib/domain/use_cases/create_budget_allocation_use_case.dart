import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_allocation_data.dart';
import '../repositories/budget_allocations.dart';

class CreateBudgetAllocationUseCase {
  const CreateBudgetAllocationUseCase({
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _allocations = allocations,
        _analytics = analytics;

  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetAllocationData allocation,
  }) {
    unawaited(_analytics.log(AnalyticsEvent.createBudgetAllocation(userId)));
    throw UnimplementedError();
  }
}
