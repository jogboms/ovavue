import 'package:rxdart/streams.dart';

import '../entities/budget_allocation_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetAllocationsUseCase {
  const FetchBudgetAllocationsUseCase({
    required BudgetAllocationsRepository allocations,
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
  })  : _allocations = allocations,
        _budgets = budgets,
        _plans = plans;

  final BudgetAllocationsRepository _allocations;
  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;

  Stream<NormalizedBudgetAllocationEntityList> call({
    required String userId,
    required String budgetId,
  }) =>
      CombineLatestStream.combine3<BudgetAllocationEntityList, BudgetEntityList, BudgetPlanEntityList,
          NormalizedBudgetAllocationEntityList>(
        _allocations.fetch(userId: userId, budgetId: budgetId),
        _budgets.fetch(userId),
        _plans.fetch(userId),
        (BudgetAllocationEntityList allocations, BudgetEntityList budgets, BudgetPlanEntityList plans) => allocations
            .map(
              (BudgetAllocationEntity allocation) => NormalizedBudgetAllocationEntity(
                id: allocation.id,
                path: allocation.path,
                amount: allocation.amount,
                startedAt: allocation.startedAt,
                endedAt: allocation.endedAt,
                budget: budgets.firstWhere((BudgetEntity budget) => budget.id == allocation.budget.id),
                plan: plans.firstWhere((BudgetPlanEntity plan) => plan.id == allocation.plan.id),
                createdAt: allocation.createdAt,
                updatedAt: allocation.updatedAt,
              ),
            )
            .toList(),
      );
}
