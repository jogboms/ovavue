import 'package:rxdart/streams.dart';

import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetsUseCase {
  const FetchBudgetsUseCase({
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _budgets = budgets,
        _plans = plans,
        _categories = categories;

  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetEntityList> call(String userId) => CombineLatestStream.combine3<BudgetEntityList,
          BudgetPlanEntityList, BudgetCategoryEntityList, NormalizedBudgetEntityList>(
        _budgets.fetch(userId),
        _plans.fetch(userId),
        _categories.fetch(userId),
        (
          BudgetEntityList budgets,
          BudgetPlanEntityList plans,
          BudgetCategoryEntityList categories,
        ) =>
            budgets.normalize(plans.normalize(categories)),
      );
}
