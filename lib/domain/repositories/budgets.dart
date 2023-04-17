import '../entities/budget_entity.dart';
import '../entities/create_budget_data.dart';
import '../entities/reference_entity.dart';
import '../entities/update_budget_data.dart';

abstract class BudgetsRepository {
  Future<String> create(String userId, CreateBudgetData budget);

  Future<bool> update(UpdateBudgetData budget);

  Future<bool> delete(String path);

  Future<bool> addPlan({
    required String userId,
    required String budgetId,
    required ReferenceEntity plan,
  });

  Future<bool> removePlan({
    required String path,
    required String planId,
  });

  Stream<BudgetEntityList> fetch(String userId);

  Stream<BudgetEntity> fetchActiveBudget(String userId);

  Stream<BudgetEntity> fetchOne({
    required String userId,
    required String budgetId,
  });
}
