import 'package:ovavue/domain/entities/budget_category_entity.dart';
import 'package:ovavue/domain/entities/create_budget_category_data.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/entities/update_budget_category_data.dart';

abstract class BudgetCategoriesRepository {
  Future<String> create(String userId, CreateBudgetCategoryData category);

  Future<bool> update(UpdateBudgetCategoryData category);

  Future<bool> delete(ReferenceEntity reference);

  Stream<BudgetCategoryEntityList> fetchAll(String userId);
}
