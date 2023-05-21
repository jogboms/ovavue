import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class BudgetsLocalImpl implements BudgetsRepository {
  const BudgetsLocalImpl(this._db);

  final Database _db;

  @override
  Future<ReferenceEntity> create(String userId, CreateBudgetData budget) =>
      _db.budgetsDao.createBudget(budget).then((_) => (id: _.id, path: _.path));

  @override
  Future<bool> activateBudget(ReferenceEntity reference) => _db.budgetsDao.activateBudget(reference.id);

  @override
  Future<bool> deactivateBudget({required ReferenceEntity reference, required DateTime? endedAt}) =>
      _db.budgetsDao.deactivateBudget(reference.id, endedAt);

  @override
  Future<bool> delete(ReferenceEntity reference) => _db.budgetsDao.deleteBudget(reference.id);

  @override
  Stream<BudgetEntity?> fetchActiveBudget(String userId) => _db.budgetsDao.watchActiveBudget();

  @override
  Stream<BudgetEntityList> fetchAll(String userId) => _db.budgetsDao.watchAllBudgets();

  @override
  Stream<BudgetEntity> fetchOne({required String userId, required String budgetId}) =>
      _db.budgetsDao.watchSingleBudget(budgetId);

  @override
  Future<bool> update(UpdateBudgetData budget) => _db.budgetsDao.updateBudget(budget);
}
