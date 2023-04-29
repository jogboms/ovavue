import '../entities/budget_allocation_entity.dart';
import '../repositories/budget_allocations.dart';

class FetchBudgetAllocationsByPlanUseCase {
  const FetchBudgetAllocationsByPlanUseCase({
    required BudgetAllocationsRepository allocations,
  }) : _allocations = allocations;

  final BudgetAllocationsRepository _allocations;

  Stream<BudgetAllocationEntityList> call({
    required String userId,
    required String planId,
  }) =>
      _allocations.fetchByPlan(userId: userId, planId: planId);
}
