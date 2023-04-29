import '../entities/budget_category_entity.dart';
import '../entities/create_budget_category_data.dart';
import '../entities/update_budget_category_data.dart';

abstract class BudgetCategoriesRepository {
  Future<String> create(String userId, CreateBudgetCategoryData category);

  Future<bool> update(UpdateBudgetCategoryData category);

  Future<bool> delete({
    required String id,
    required String path,
  });

  Stream<BudgetCategoryEntityList> fetchAll(String userId);
}
