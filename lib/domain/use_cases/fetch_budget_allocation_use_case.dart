import 'package:rxdart/streams.dart';

import '../entities/budget_allocation_entity.dart';
import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetAllocationUseCase {
  const FetchBudgetAllocationUseCase({
    required BudgetAllocationsRepository allocations,
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _allocations = allocations,
        _budgets = budgets,
        _plans = plans,
        _categories = categories;

  final BudgetAllocationsRepository _allocations;
  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetAllocationEntity?> call({
    required String userId,
    required String budgetId,
    required String planId,
  }) =>
      CombineLatestStream.combine4(
        _allocations.fetchOne(userId: userId, budgetId: budgetId, planId: planId),
        _budgets.fetchOne(userId: userId, budgetId: budgetId),
        _plans.fetchOne(userId: userId, planId: planId),
        _categories.fetch(userId),
        (
          BudgetAllocationEntity? allocation,
          BudgetEntity budget,
          BudgetPlanEntity plan,
          BudgetCategoryEntityList categories,
        ) =>
            allocation?.normalize(budget.normalize(), plan.normalize(categories)),
      );
}
