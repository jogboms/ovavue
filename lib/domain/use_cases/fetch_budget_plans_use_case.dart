import '../entities/budget_plan_entity.dart';
import '../repositories/budget_plans.dart';

class FetchBudgetPlansUseCase {
  const FetchBudgetPlansUseCase({
    required BudgetPlansRepository plans,
  }) : _plans = plans;

  final BudgetPlansRepository _plans;

  Stream<NormalizedBudgetPlanEntityList> call(String userId) {
    throw UnimplementedError();
  }
}
