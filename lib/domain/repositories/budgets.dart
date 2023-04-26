import '../entities/budget_entity.dart';
import '../entities/create_budget_data.dart';
import '../entities/reference_entity.dart';
import '../entities/update_budget_data.dart';

abstract class BudgetsRepository {
  Future<ReferenceEntity> create(String userId, CreateBudgetData budget);

  Future<bool> update(UpdateBudgetData budget);

  Future<bool> delete(String path);

  Stream<BudgetEntityList> fetch(String userId);

  Stream<BudgetEntity?> fetchActiveBudget(String userId);

  Future<bool> deactivateBudget({
    required String budgetPath,
    required DateTime endedAt,
  });

  Stream<BudgetEntity> fetchOne({
    required String userId,
    required String budgetId,
  });
}
