import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_allocation_data.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budgets.dart';

class CreateBudgetAllocationUseCase {
  const CreateBudgetAllocationUseCase({
    required BudgetsRepository budgets,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _budgets = budgets,
        _allocations = allocations,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetAllocationData allocation,
  }) {
    _analytics.log(AnalyticsEvent.createBudgetAllocation(userId)).ignore();
    return _allocations.create(userId, allocation).then(
          (String allocationId) => _budgets
              .addPlan(userId: userId, budgetId: allocation.budget.id, plan: allocation.plan)
              .then((_) => allocationId),
        );
  }
}
