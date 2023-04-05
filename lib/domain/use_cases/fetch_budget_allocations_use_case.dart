import 'package:rxdart/streams.dart';

import '../entities/budget_allocation_entity.dart';
import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetAllocationsUseCase {
  const FetchBudgetAllocationsUseCase({
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

  Stream<NormalizedBudgetAllocationEntityList> call({
    required String userId,
    required String budgetId,
    required String planId,
  }) =>
      CombineLatestStream.combine4<BudgetAllocationEntityList, BudgetEntity, BudgetPlanEntityList,
          BudgetCategoryEntityList, NormalizedBudgetAllocationEntityList>(
        _allocations.fetch(userId: userId, budgetId: budgetId, planId: planId),
        _budgets.fetchOne(userId: userId, budgetId: budgetId),
        _plans.fetch(userId),
        _categories.fetch(userId),
        (
          BudgetAllocationEntityList allocations,
          BudgetEntity budget,
          BudgetPlanEntityList plans,
          BudgetCategoryEntityList categories,
        ) =>
            allocations.normalize(budget.normalize(plans.normalize(categories))),
      );
}
