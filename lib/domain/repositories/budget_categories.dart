import '../entities/budget_category_entity.dart';
import '../entities/create_budget_category_data.dart';

abstract class BudgetCategoriesRepository {
  Future<String> create(String userId, CreateBudgetCategoryData category);

  Future<bool> delete(String path);

  Stream<BudgetCategoryEntityList> fetch(String userId);
}
