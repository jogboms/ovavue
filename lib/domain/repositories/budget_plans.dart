import '../entities/budget_plan_entity.dart';
import '../entities/create_budget_plan_data.dart';
import '../entities/update_budget_plan_data.dart';

abstract class BudgetPlansRepository {
  Future<String> create(String userId, CreateBudgetPlanData plan);

  Future<bool> update(UpdateBudgetPlanData plan);

  Future<bool> delete(String path);

  Stream<BudgetPlanEntityList> fetch(String userId);

  Stream<BudgetPlanEntity> fetchOne({required String userId, required String planId});

  Stream<BudgetPlanEntityList> fetchByCategory({
    required String userId,
    required String categoryId,
  });
}
