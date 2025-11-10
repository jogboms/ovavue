import 'package:collection/collection.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/budget_category_state.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/selected_budget_category_by_budget_provider.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_budget_category_provider.g.dart';

@Riverpod(dependencies: <Object>[budgetPlans, budgetCategories])
Stream<BudgetCategoryState> selectedBudgetCategory(Ref ref, String id) async* {
  final category = await ref.watch(
    budgetCategoriesProvider.selectAsync(
      (List<BudgetCategoryViewModel> categories) =>
          categories.firstWhereOrNull((BudgetCategoryViewModel e) => e.id == id),
    ),
  );

  if (category != null) {
    final plans = await ref.watch(
      budgetPlansProvider.selectAsync(
        (List<BudgetPlanViewModel> plans) => plans.where((BudgetPlanViewModel e) => e.category.id == id),
      ),
    );

    yield BudgetCategoryState(
      category: category,
      plans: plans.map((BudgetPlanViewModel e) => e.toViewModel(null)).toList(growable: false),
      allocation: null,
      budget: null,
    );
  }
}
