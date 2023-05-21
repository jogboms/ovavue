import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class BudgetAllocationsLocalImpl implements BudgetAllocationsRepository {
  const BudgetAllocationsLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetAllocationData allocation) =>
      _db.budgetAllocationsDao.createAllocation(allocation);

  @override
  Future<bool> createAll(String userId, List<CreateBudgetAllocationData> allocations) =>
      _db.budgetAllocationsDao.createAllocations(allocations);

  @override
  Future<bool> delete(ReferenceEntity reference) => _db.budgetAllocationsDao.deleteAllocation(reference.id);

  @override
  Future<bool> deleteByPlan({required String userId, required String planId}) =>
      _db.budgetAllocationsDao.deleteAllocationByPlan(planId);

  @override
  Stream<BudgetAllocationEntityList> fetchAll(String userId) => _db.budgetAllocationsDao.watchAllBudgetAllocations();

  @override
  Stream<BudgetAllocationEntityList> fetchByBudget({required String userId, required String budgetId}) =>
      _db.budgetAllocationsDao.watchAllBudgetAllocationsByBudget(budgetId);

  @override
  Stream<BudgetAllocationEntityList> fetchByPlan({required String userId, required String planId}) =>
      _db.budgetAllocationsDao.watchAllBudgetAllocationsByPlan(planId);

  @override
  Stream<BudgetAllocationEntity?> fetchOne({
    required String userId,
    required String budgetId,
    required String planId,
  }) =>
      _db.budgetAllocationsDao.watchSingleBudgetPlan(budgetId: budgetId, planId: planId);

  @override
  Future<bool> update(UpdateBudgetAllocationData allocation) => _db.budgetAllocationsDao.updateAllocation(allocation);
}
