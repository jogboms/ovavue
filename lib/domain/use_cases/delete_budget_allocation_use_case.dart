import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_allocations.dart';

class DeleteBudgetAllocationUseCase {
  const DeleteBudgetAllocationUseCase({
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _allocations = allocations,
        _analytics = analytics;

  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<bool> call({
    required String id,
    required String path,
  }) {
    _analytics.log(AnalyticsEvent.deleteBudgetAllocation(path)).ignore();
    return _allocations.delete((id: id, path: path));
  }
}
