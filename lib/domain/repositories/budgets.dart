import '../entities/budget_entity.dart';
import '../entities/create_budget_data.dart';
import '../entities/update_budget_data.dart';

abstract class BudgetsRepository {
  Future<String> create(String userId, CreateBudgetData budget);

  Future<bool> update(UpdateBudgetData budget);

  Future<bool> delete(String path);

  Stream<BudgetEntityList> fetch(String userId);

  Stream<BudgetEntity> fetchActiveBudget(String userId);

  Stream<BudgetEntity> fetchOne({
    required String userId,
    required String budgetId,
  });
}
