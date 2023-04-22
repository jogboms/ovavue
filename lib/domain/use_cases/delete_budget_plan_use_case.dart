import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_plans.dart';

class DeleteBudgetPlanUseCase {
  const DeleteBudgetPlanUseCase({
    required BudgetPlansRepository plans,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _plans = plans,
        _allocations = allocations,
        _analytics = analytics;

  final BudgetPlansRepository _plans;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<bool> call({required String userId, required String id, required String path}) {
    _analytics.log(AnalyticsEvent.deleteBudgetPlan(path)).ignore();
    return _allocations.deleteByPlan(userId: userId, planId: id).then((bool successful) {
      if (successful) {
        return _plans.delete(path);
      }
      return successful;
    });
  }
}
