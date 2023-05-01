import '../entities/budget_category_entity.dart';
import '../entities/create_budget_category_data.dart';
import '../entities/reference_entity.dart';
import '../entities/update_budget_category_data.dart';

abstract class BudgetCategoriesRepository {
  Future<String> create(String userId, CreateBudgetCategoryData category);

  Future<bool> update(UpdateBudgetCategoryData category);

  Future<bool> delete(ReferenceEntity reference);

  Stream<BudgetCategoryEntityList> fetchAll(String userId);
}
