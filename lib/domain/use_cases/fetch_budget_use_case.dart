import 'package:rxdart/streams.dart';

import '../entities/budget_category_entity.dart';
import '../entities/budget_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';
import '../repositories/budgets.dart';

class FetchBudgetUseCase {
  const FetchBudgetUseCase({
    required BudgetsRepository budgets,
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _budgets = budgets,
        _plans = plans,
        _categories = categories;

  final BudgetsRepository _budgets;
  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetEntity> call({
    required String userId,
    required String budgetId,
  }) =>
      CombineLatestStream.combine3(
        _budgets.fetchOne(userId: userId, budgetId: budgetId),
        _plans.fetch(userId),
        _categories.fetch(userId),
        (
          BudgetEntity budget,
          BudgetPlanEntityList plans,
          BudgetCategoryEntityList categories,
        ) {
          final Iterable<String> budgetPlansById = budget.plans.map((_) => _.id);
          return budget.normalize(
            plans
                .where((_) => budgetPlansById.contains(_.id))
                .map((_) => _.normalize(categories))
                .toList(growable: false),
          );
        },
      );
}
