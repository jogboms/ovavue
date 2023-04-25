import 'package:ovavue/core.dart';
import 'package:rxdart/streams.dart';

import '../entities/budget_allocation_entity.dart';
import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetPlansByBudgetUseCase {
  const FetchBudgetPlansByBudgetUseCase({
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

  Stream<BudgetIdToPlansMap> call(String userId) => CombineLatestStream.combine4(
        _allocations.fetchAll(userId),
        _budgets.fetch(userId),
        _plans.fetch(userId),
        _categories.fetch(userId),
        (
          BudgetAllocationEntityList allocations,
          BudgetEntityList budgets,
          BudgetPlanEntityList plans,
          BudgetCategoryEntityList categories,
        ) {
          final Map<String, NormalizedBudgetPlanEntity> plansById = plans.normalize(categories).foldToMap((_) => _.id);

          Set<NormalizedBudgetPlanEntity> updatePlans(String planId, Set<NormalizedBudgetPlanEntity> plans) {
            final NormalizedBudgetPlanEntity? plan = plansById[planId];
            if (plan == null) {
              return plans;
            }

            return <NormalizedBudgetPlanEntity>{...plans, plan};
          }

          return allocations.fold(<String, Set<NormalizedBudgetPlanEntity>>{}, (
            BudgetIdToPlansMap previousValue,
            BudgetAllocationEntity allocation,
          ) {
            final String planId = allocation.plan.id;
            return previousValue
              ..update(
                allocation.budget.id,
                (Set<NormalizedBudgetPlanEntity> plans) => updatePlans(planId, plans),
                ifAbsent: () => updatePlans(planId, const <NormalizedBudgetPlanEntity>{}),
              );
          });
        },
      );
}

typedef BudgetIdToPlansMap = Map<String, Set<NormalizedBudgetPlanEntity>>;
