import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/budget_category_state.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'models.dart';

part 'selected_budget_category_by_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgets, budgetPlans, budgetCategories])
Stream<BudgetCategoryState> selectedBudgetCategoryByBudget(
  SelectedBudgetCategoryByBudgetRef ref, {
  required String id,
  required String budgetId,
}) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  final category = await ref.watch(
    budgetCategoriesProvider.selectAsync(
      (List<BudgetCategoryViewModel> categories) => categories.firstWhere((BudgetCategoryViewModel e) => e.id == id),
    ),
  );
  final budget = await ref.watch(
    budgetsProvider.selectAsync(
      (List<BudgetViewModel> budgets) => budgets.firstWhere((BudgetViewModel e) => e.id == budgetId),
    ),
  );
  final budgetPlans = await ref.watch(
    budgetPlansProvider.selectAsync(
      (List<BudgetPlanViewModel> plans) => plans.where((BudgetPlanViewModel e) => e.category.id == id),
    ),
  );

  yield* registry.get<FetchBudgetAllocationsByBudgetUseCase>().call(userId: user.id, budgetId: budgetId).map(
    (BudgetAllocationEntityList allocations) {
      final allocationsByPlan = allocations.foldToMap(
        (BudgetAllocationEntity e) => e.plan.id,
      );
      final Iterable<BudgetCategoryPlanViewModel> plans = budgetPlans
          .map((BudgetPlanViewModel e) => e.toViewModel(allocationsByPlan[e.id]?.amount.asMoney))
          .sorted(
            (BudgetCategoryPlanViewModel a, BudgetCategoryPlanViewModel b) =>
                (b.$2 ?? Money.zero).compareTo(a.$2 ?? Money.zero),
          );

      return BudgetCategoryState(
        category: category,
        allocation: plans.map((BudgetCategoryPlanViewModel e) => e.$2).nonNulls.sum(),
        budget: budget,
        plans: plans.toList(growable: false),
      );
    },
  ).distinct();
}
