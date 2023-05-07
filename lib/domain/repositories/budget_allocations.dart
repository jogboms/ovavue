import '../entities/budget_allocation_entity.dart';
import '../entities/create_budget_allocation_data.dart';
import '../entities/update_budget_allocation_data.dart';

abstract class BudgetAllocationsRepository {
  Future<String> create(String userId, CreateBudgetAllocationData allocation);

  Future<bool> createAll(String userId, List<CreateBudgetAllocationData> allocations);

  Future<bool> update(UpdateBudgetAllocationData allocation);

  Future<bool> delete({
    required String id,
    required String path,
  });

  Future<bool> deleteByPlan({
    required String userId,
    required String planId,
  });

  Stream<BudgetAllocationEntityList> fetchAll(String userId);

  Stream<BudgetAllocationEntityList> fetchByBudget({
    required String userId,
    required String budgetId,
  });

  Stream<BudgetAllocationEntityList> fetchByPlan({
    required String userId,
    required String planId,
  });

  Stream<BudgetAllocationEntity?> fetchOne({
    required String userId,
    required String budgetId,
    required String planId,
  });
}
