import '../entities/budget_plan_entity.dart';
import '../repositories/budget_plans.dart';

class FetchBudgetPlansUseCase {
  const FetchBudgetPlansUseCase({
    required BudgetPlansRepository plans,
  }) : _plans = plans;

  final BudgetPlansRepository _plans;

  Stream<BudgetPlanEntityList> call(String userId) => _plans.fetchAll(userId);
}
