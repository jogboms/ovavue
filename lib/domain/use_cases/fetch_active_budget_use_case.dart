import 'package:rxdart/streams.dart';

import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchActiveBudgetUseCase {
  const FetchActiveBudgetUseCase({
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _budgets = budgets,
        _plans = plans,
        _categories = categories;

  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetEntity> call(String userId) => CombineLatestStream.combine3(
        _budgets.fetchActiveBudget(userId),
        _plans.fetch(userId),
        _categories.fetch(userId),
        (
          BudgetEntity budget,
          BudgetPlanEntityList plans,
          BudgetCategoryEntityList categories,
        ) =>
            budget.normalize(plans.normalize(categories)),
      );
}
