import '../entities/budget_allocation_entity.dart';

class FetchBudgetAllocationsUseCase {
  const FetchBudgetAllocationsUseCase();

  Stream<BudgetAllocationEntityList> call({
    required String userId,
    required String budgetId,
  }) {
    throw UnimplementedError();
  }
}
