import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';
import 'budget_category_state.dart';
import 'models.dart';

export 'models.dart';

part 'selected_budget_category_by_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgets, budgetPlans, budgetCategories])
Stream<BudgetCategoryState> selectedBudgetCategoryByBudget(
  SelectedBudgetCategoryByBudgetRef ref, {
  required String id,
  required String budgetId,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final BudgetCategoryViewModel category = await ref.watch(
    budgetCategoriesProvider.selectAsync(
      (List<BudgetCategoryViewModel> categories) => categories.firstWhere((_) => _.id == id),
    ),
  );
  final BudgetViewModel budget = await ref.watch(
    budgetsProvider.selectAsync(
      (List<BudgetViewModel> budgets) => budgets.firstWhere((_) => _.id == budgetId),
    ),
  );
  final Iterable<BudgetPlanViewModel> budgetPlans = await ref.watch(
    budgetPlansProvider.selectAsync(
      (List<BudgetPlanViewModel> plans) => plans.where((_) => _.category.id == id),
    ),
  );

  yield* registry.get<FetchBudgetAllocationsByBudgetUseCase>().call(userId: user.id, budgetId: budgetId).map(
    (NormalizedBudgetAllocationEntityList allocations) {
      final Map<String, NormalizedBudgetAllocationEntity> allocationsByPlan = allocations.foldToMap((_) => _.plan.id);
      final List<BudgetCategoryPlanViewModel> plans = budgetPlans
          .map((_) => _.toViewModel(allocationsByPlan[_.id]?.amount.asMoney))
          .sorted(
            (
              BudgetCategoryPlanViewModel a,
              BudgetCategoryPlanViewModel b,
            ) =>
                (b.allocation ?? Money.zero).compareTo(a.allocation ?? Money.zero),
          )
          .toList(growable: false);

      return BudgetCategoryState(
        category: category,
        allocation: plans.map((_) => _.allocation).whereNotNull().sum(),
        budget: budget,
        plans: plans,
      );
    },
  ).distinct();
}
