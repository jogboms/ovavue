import 'package:ovavue/data/local_database.dart';
import 'package:ovavue/domain.dart';

class BudgetCategoriesLocalImpl implements BudgetCategoriesRepository {
  const BudgetCategoriesLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetCategoryData category) =>
      _db.budgetCategoriesDao.createCategory(category).then((BudgetCategoryEntity e) => e.id);

  @override
  Future<bool> delete(ReferenceEntity reference) => _db.budgetCategoriesDao.deleteCategory(reference.id);

  @override
  Stream<BudgetCategoryEntityList> fetchAll(String userId) => _db.budgetCategoriesDao.watchAllBudgetCategories();

  @override
  Future<bool> update(UpdateBudgetCategoryData category) => _db.budgetCategoriesDao.updateCategory(category);
}
