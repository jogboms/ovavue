import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class DeleteBudgetPlanUseCase {
  const DeleteBudgetPlanUseCase({
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _budgets = budgets,
        _plans = plans,
        _allocations = allocations,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<bool> call({required String id, required String path}) {
    _analytics.log(AnalyticsEvent.deleteBudgetPlan(path)).ignore();
    return _plans.delete(path);
  }
}
