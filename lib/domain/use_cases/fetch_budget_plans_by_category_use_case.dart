import 'package:rxdart/streams.dart';

import '../entities/budget_category_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_categories.dart';
import '../repositories/budget_plans.dart';

class FetchBudgetPlansByCategoryUseCase {
  const FetchBudgetPlansByCategoryUseCase({
    required BudgetPlansRepository plans,
    required BudgetCategoriesRepository categories,
  })  : _plans = plans,
        _categories = categories;

  final BudgetPlansRepository _plans;
  final BudgetCategoriesRepository _categories;

  Stream<NormalizedBudgetPlanEntityList> call({
    required String userId,
    required String categoryId,
  }) =>
      CombineLatestStream.combine2(
        _plans.fetchByCategory(userId: userId, categoryId: categoryId),
        _categories.fetch(userId),
        (BudgetPlanEntityList plans, BudgetCategoryEntityList categories) => plans.normalize(categories),
      );
}
