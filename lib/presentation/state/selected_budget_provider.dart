import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state/budget_state.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:ovavue/presentation/state/user_provider.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/transformers.dart';

part 'selected_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<BudgetState> selectedBudget(Ref ref, String id) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetUseCase>()
      .call(userId: user.id, budgetId: id)
      .switchMap(
        (BudgetEntity budget) => registry
            .get<FetchBudgetAllocationsByBudgetUseCase>()
            .call(userId: user.id, budgetId: budget.id)
            .map((BudgetAllocationEntityList allocations) => _deriveState(budget, allocations)),
      )
      .distinct();
}

BudgetState _deriveState(
  BudgetEntity budget,
  BudgetAllocationEntityList allocations,
) {
  final allocationByPlan = allocations.foldToMap(
    (BudgetAllocationEntity e) => e.plan.id,
  );
  final budgetPlans = allocations.map((BudgetAllocationEntity e) => e.plan);
  final allocationByCategory = budgetPlans.groupFoldBy(
    (BudgetPlanEntity e) => e.category.id,
    (int? previous, BudgetPlanEntity plan) => (previous ?? 0) + (allocationByPlan[plan.id]?.amount ?? 0),
  );
  final categories = budgetPlans
      .uniqueBy((BudgetPlanEntity e) => e.category.id)
      .map((BudgetPlanEntity e) => e.category)
      .map(
        (BudgetCategoryEntity category) => category.toViewModel(
          allocationByCategory[category.id]?.asMoney ?? Money.zero,
        ),
      );
  final plans = budgetPlans.map(
    (BudgetPlanEntity plan) => BudgetPlanViewModel.fromEntity(
      plan,
      allocationByPlan[plan.id]?.toViewModel(),
    ),
  );

  return BudgetState(
    budget: BudgetViewModel.fromEntity(budget),
    plans: plans.sortedByMoney(),
    allocation: allocationByCategory.values.sum.asMoney,
    categories: categories.sorted(
      (SelectedBudgetCategoryViewModel a, SelectedBudgetCategoryViewModel b) => b.$2.compareTo(a.$2),
    ),
  );
}
