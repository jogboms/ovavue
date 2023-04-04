import '../entities/budget_allocation_entity.dart';
import '../entities/create_budget_allocation_data.dart';

abstract class BudgetAllocationsRepository {
  Future<String> create(String userId, CreateBudgetAllocationData allocation);

  Future<bool> delete(String path);

  Stream<BudgetAllocationEntityList> fetch({
    required String userId,
    required String budgetId,
  });
}
