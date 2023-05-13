import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class BudgetCategoriesLocalImpl implements BudgetCategoriesRepository {
  const BudgetCategoriesLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetCategoryData category) =>
      _db.budgetCategoriesDao.createCategory(category).then((_) => _.id);

  @override
  Future<bool> delete(ReferenceEntity reference) => _db.budgetCategoriesDao.deleteCategory(reference.id);

  @override
  Stream<BudgetCategoryEntityList> fetchAll(String userId) => _db.budgetCategoriesDao.watchAllBudgetCategories();

  @override
  Future<bool> update(UpdateBudgetCategoryData category) => _db.budgetCategoriesDao.updateCategory(category);
}
