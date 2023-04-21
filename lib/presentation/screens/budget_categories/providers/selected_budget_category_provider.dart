import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import 'budget_category_state.dart';
import 'selected_budget_category_by_budget_provider.dart';

part 'selected_budget_category_provider.g.dart';

@Riverpod(dependencies: <Object>[budgetPlans, budgetCategories])
Stream<BudgetCategoryState> selectedBudgetCategory(SelectedBudgetCategoryRef ref, String id) async* {
  final BudgetCategoryViewModel category = await ref.watch(
    budgetCategoriesProvider.selectAsync(
      (List<BudgetCategoryViewModel> categories) => categories.firstWhere((_) => _.id == id),
    ),
  );
  final Iterable<BudgetPlanViewModel> plans = await ref.watch(
    budgetPlansProvider.selectAsync(
      (List<BudgetPlanViewModel> plans) => plans.where((_) => _.category.id == id),
    ),
  );

  yield BudgetCategoryState(
    category: category,
    plans: plans.map((_) => _.toViewModel(null)).toList(growable: false),
    allocation: null,
    budget: null,
  );
}
