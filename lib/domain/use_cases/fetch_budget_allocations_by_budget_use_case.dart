import 'package:ovavue/domain/entities/budget_allocation_entity.dart';
import 'package:ovavue/domain/repositories/budget_allocations.dart';

class FetchBudgetAllocationsByBudgetUseCase {
  const FetchBudgetAllocationsByBudgetUseCase({
    required BudgetAllocationsRepository allocations,
  }) : _allocations = allocations;

  final BudgetAllocationsRepository _allocations;

  Stream<BudgetAllocationEntityList> call({
    required String userId,
    required String budgetId,
  }) => _allocations.fetchByBudget(userId: userId, budgetId: budgetId);
}
