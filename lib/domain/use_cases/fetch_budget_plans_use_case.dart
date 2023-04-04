import 'package:rxdart/streams.dart';

import '../entities/budget_category_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';

class FetchBudgetPlansUseCase {
  const FetchBudgetPlansUseCase({
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _plans = plans,
        _categories = categories;

  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetPlanEntityList> call(String userId) =>
      CombineLatestStream.combine2<BudgetPlanEntityList, BudgetCategoryEntityList, NormalizedBudgetPlanEntityList>(
        _plans.fetch(userId),
        _categories.fetch(userId),
        (BudgetPlanEntityList plans, BudgetCategoryEntityList categories) => plans
            .map(
              (BudgetPlanEntity plan) => NormalizedBudgetPlanEntity(
                id: plan.id,
                path: plan.path,
                title: plan.title,
                description: plan.description,
                category: categories.firstWhere((BudgetCategoryEntity category) => category.id == plan.category.id),
                createdAt: plan.createdAt,
                updatedAt: plan.updatedAt,
              ),
            )
            .toList(),
      );
}
