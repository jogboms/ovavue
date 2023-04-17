import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budgets.dart';

class DeleteBudgetAllocationUseCase {
  const DeleteBudgetAllocationUseCase({
    required BudgetsRepository budgets,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _budgets = budgets,
        _allocations = allocations,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<bool> call({required String budgetPath, required String planId, required String path}) {
    _analytics.log(AnalyticsEvent.deleteBudgetAllocation(path)).ignore();
    return _budgets.removePlan(path: budgetPath, planId: planId).then((bool successful) {
      if (successful) {
        return _allocations.delete(path);
      }
      return successful;
    });
  }
}
