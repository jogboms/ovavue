import 'package:ovavue/data/local_database.dart';
import 'package:ovavue/domain.dart';

class BudgetPlansLocalImpl implements BudgetPlansRepository {
  const BudgetPlansLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetPlanData plan) => _db.budgetPlansDao.createPlan(plan);

  @override
  Future<bool> delete(ReferenceEntity reference) => _db.budgetPlansDao.deletePlan(reference.id);

  @override
  Stream<BudgetPlanEntityList> fetchAll(String userId) => _db.budgetPlansDao.watchAllBudgetPlans();

  @override
  Stream<BudgetPlanEntityList> fetchByCategory({required String userId, required String categoryId}) =>
      _db.budgetPlansDao.watchAllBudgetPlansByCategory(categoryId);

  @override
  Stream<BudgetPlanEntity> fetchOne({required String userId, required String planId}) =>
      _db.budgetPlansDao.watchSingleBudgetPlan(planId);

  @override
  Future<bool> update(UpdateBudgetPlanData plan) => _db.budgetPlansDao.updatePlan(plan);
}
