import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/transformers.dart';

import '../models.dart';
import '../state.dart';
import '../utils.dart';

part 'selected_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<BudgetState> selectedBudget(SelectedBudgetRef ref, String id) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetUseCase>()
      .call(userId: user.id, budgetId: id)
      .switchMap(
        (NormalizedBudgetEntity budget) => registry
            .get<FetchBudgetAllocationsByBudgetUseCase>()
            .call(userId: user.id, budgetId: budget.id)
            .map((NormalizedBudgetAllocationEntityList allocations) => _deriveState(budget, allocations)),
      )
      .distinct();
}

class BudgetState with EquatableMixin {
  const BudgetState({
    required this.budget,
    required this.allocation,
    required this.categories,
  });

  final SelectedBudgetViewModel budget;
  final Money allocation;
  final List<SelectedBudgetCategoryViewModel> categories;

  @override
  List<Object> get props => <Object>[budget, allocation, categories];
}

BudgetState _deriveState(
  NormalizedBudgetEntity budget,
  NormalizedBudgetAllocationEntityList allocations,
) {
  final Map<String, NormalizedBudgetAllocationEntity> allocationByPlan = allocations.foldToMap((_) => _.plan.id);
  final NormalizedBudgetPlanEntityList budgetPlans = allocations.map((_) => _.plan).toList(growable: false);
  final Map<String, int> allocationByCategory = budgetPlans.groupFoldBy(
    (_) => _.category.id,
    (int? previous, NormalizedBudgetPlanEntity plan) => (previous ?? 0) + (allocationByPlan[plan.id]?.amount ?? 0),
  );
  final Iterable<SelectedBudgetCategoryViewModel> categories =
      budgetPlans.uniqueBy((_) => _.category.id).map((_) => _.category).map(
            (BudgetCategoryEntity category) => category.toViewModel(
              allocationByCategory[category.id]?.asMoney ?? Money.zero,
            ),
          );
  final Map<String, SelectedBudgetCategoryViewModel> categoriesById = categories.foldToMap((_) => _.id);
  final Iterable<SelectedBudgetPlanViewModel> plans = budgetPlans.map(
    (NormalizedBudgetPlanEntity plan) => plan.toViewModel(
      allocation: allocationByPlan[plan.id]?.toViewModel(),
      category: categoriesById[plan.category.id]!,
    ),
  );

  return BudgetState(
    budget: budget.toViewModel(
      plans.sorted((SelectedBudgetPlanViewModel a, SelectedBudgetPlanViewModel b) {
        final Money moneyA = a.allocation?.amount ?? Money.zero;
        final Money moneyB = b.allocation?.amount ?? Money.zero;

        return moneyB.compareTo(moneyA);
      }),
    ),
    allocation: allocationByCategory.values.sum.asMoney,
    categories: categories.sorted(
      (SelectedBudgetCategoryViewModel a, SelectedBudgetCategoryViewModel b) => b.allocation.compareTo(a.allocation),
    ),
  );
}
