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

  Stream<NormalizedBudgetPlanEntityList> call(String userId) => CombineLatestStream.combine2(
        _plans.fetch(userId),
        _categories.fetch(userId),
        (BudgetPlanEntityList plans, BudgetCategoryEntityList categories) => plans.normalize(categories),
      );
}
