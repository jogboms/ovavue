import '../entities/budget_plan_entity.dart';
import '../entities/create_budget_plan_data.dart';

abstract class BudgetPlansRepository {
  Future<String> create(String userId, CreateBudgetPlanData plan);

  Future<bool> delete(String path);

  Stream<BudgetPlanEntityList> fetch(String userId);
}
