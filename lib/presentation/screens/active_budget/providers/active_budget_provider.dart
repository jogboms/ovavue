import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/transformers.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';

part 'active_budget_provider.g.dart';
part 'models.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<ActiveBudgetState> activeBudget(ActiveBudgetRef ref) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchActiveBudgetUseCase>()
      .call(user.id)
      .switchMap(
        (NormalizedBudgetEntity budget) => registry
            .get<FetchBudgetAllocationsUseCase>()
            .call(userId: user.id, budgetId: budget.id)
            .map((NormalizedBudgetAllocationEntityList allocations) => _deriveState(budget, allocations)),
      )
      .distinct();
}

class ActiveBudgetState with EquatableMixin {
  const ActiveBudgetState({
    required this.budget,
    required this.allocation,
    required this.categories,
  });

  final ActiveBudgetViewModel budget;
  final Money allocation;
  final List<ActiveBudgetCategoryViewModel> categories;

  @override
  List<Object> get props => <Object>[budget, allocation, categories];
}

ActiveBudgetState _deriveState(
  NormalizedBudgetEntity budget,
  NormalizedBudgetAllocationEntityList allocations,
) {
  final Map<String, NormalizedBudgetAllocationEntity> allocationByPlan = allocations.foldToMap((_) => _.plan.id);
  final Map<String, int> allocationByCategory = budget.plans.groupFoldBy(
    (_) => _.category.id,
    (int? previous, NormalizedBudgetPlanEntity plan) => (previous ?? 0) + (allocationByPlan[plan.id]?.amount ?? 0),
  );
  final Iterable<ActiveBudgetCategoryViewModel> categories =
      budget.plans.uniqueBy((_) => _.category.id).map((_) => _.category).map(
            (BudgetCategoryEntity category) => category.toViewModel(
              allocationByCategory[category.id]?.asMoney ?? Money.zero,
            ),
          );
  final Map<String, ActiveBudgetCategoryViewModel> categoriesById = categories.foldToMap((_) => _.id);
  final Iterable<ActiveBudgetPlanViewModel> plans = budget.plans.map(
    (NormalizedBudgetPlanEntity plan) => plan.toViewModel(
      allocation: allocationByPlan[plan.id]?.toViewModel(),
      category: categoriesById[plan.category.id]!,
    ),
  );

  return ActiveBudgetState(
    budget: budget.toViewModel(
      plans.sorted((ActiveBudgetPlanViewModel a, ActiveBudgetPlanViewModel b) {
        final Money? moneyA = a.allocation?.amount;
        final Money? moneyB = b.allocation?.amount;
        if (moneyA != null && moneyB != null) {
          return moneyB.compareTo(moneyA);
        }

        return 0;
      }),
    ),
    allocation: allocationByCategory.values.map((_) => _.asMoney).sum(),
    categories: categories.toList(growable: false),
  );
}
