import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/update_budget_allocation_data.dart';
import 'package:ovavue/domain/repositories/budget_allocations.dart';

class UpdateBudgetAllocationUseCase {
  const UpdateBudgetAllocationUseCase({
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  }) : _allocations = allocations,
       _analytics = analytics;

  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<bool> call(UpdateBudgetAllocationData allocation) {
    _analytics.log(AnalyticsEvent.updateBudgetAllocation(allocation.path)).ignore();
    return _allocations.update(allocation);
  }
}
