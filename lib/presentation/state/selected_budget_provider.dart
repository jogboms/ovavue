import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/transformers.dart';

import '../models.dart';
import '../utils.dart';
import 'account_provider.dart';
import 'budget_state.dart';
import 'registry_provider.dart';
import 'user_provider.dart';

part 'selected_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<BudgetState> selectedBudget(SelectedBudgetRef ref, String id) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

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
  final Map<String, BudgetAllocationEntity> allocationByPlan = allocations.foldToMap((_) => _.plan.id);
  final BudgetPlanEntityList budgetPlans = allocations.map((_) => _.plan).toList(growable: false);
  final Map<String, int> allocationByCategory = budgetPlans.groupFoldBy(
    (_) => _.category.id,
    (int? previous, BudgetPlanEntity plan) => (previous ?? 0) + (allocationByPlan[plan.id]?.amount ?? 0),
  );
  final Iterable<SelectedBudgetCategoryViewModel> categories =
      budgetPlans.uniqueBy((_) => _.category.id).map((_) => _.category).map(
            (BudgetCategoryEntity category) => category.toViewModel(
              allocationByCategory[category.id]?.asMoney ?? Money.zero,
            ),
          );
  final Iterable<BudgetPlanViewModel> plans = budgetPlans.map(
    (BudgetPlanEntity plan) => BudgetPlanViewModel.fromEntity(
      plan,
      allocationByPlan[plan.id]?.toViewModel(),
    ),
  );

  return BudgetState(
    budget: BudgetViewModel.fromEntity(budget),
    plans: plans.sorted((BudgetPlanViewModel a, BudgetPlanViewModel b) {
      final Money moneyA = a.allocation?.amount ?? Money.zero;
      final Money moneyB = b.allocation?.amount ?? Money.zero;

      return moneyB.compareTo(moneyA);
    }),
    allocation: allocationByCategory.values.sum.asMoney,
    categories: categories.sorted(
      (SelectedBudgetCategoryViewModel a, SelectedBudgetCategoryViewModel b) => b.$2.compareTo(a.$2),
    ),
  );
}
