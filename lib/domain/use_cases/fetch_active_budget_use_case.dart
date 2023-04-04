import 'package:rxdart/streams.dart';

import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchActiveBudgetUseCase {
  const FetchActiveBudgetUseCase({
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
  })  : _budgets = budgets,
        _plans = plans;

  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;

  Stream<NormalizedBudgetEntity> call(String userId) =>
      CombineLatestStream.combine2<BudgetEntity, BudgetPlanEntityList, NormalizedBudgetEntity>(
        _budgets.fetchActiveBudget(userId),
        _plans.fetch(userId),
        (BudgetEntity budget, BudgetPlanEntityList plans) => NormalizedBudgetEntity(
          id: budget.id,
          path: budget.path,
          title: budget.title,
          description: budget.description,
          amount: budget.amount,
          startedAt: budget.startedAt,
          endedAt: budget.endedAt,
          plans: plans
              .where((BudgetPlanEntity plan) => budget.plans.map((_) => _.id).contains(plan.id))
              .toList(growable: false),
          createdAt: budget.createdAt,
          updatedAt: budget.updatedAt,
        ),
      );
}
