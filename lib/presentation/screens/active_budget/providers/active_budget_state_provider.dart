import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/transformers.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';

part 'active_budget_state_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<ActiveBudgetState> activeBudget(ActiveBudgetRef ref) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final FetchBudgetAllocationsUseCase fetchBudgetAllocationsUseCase = registry.get();

  yield* registry
      .get<FetchActiveBudgetUseCase>()
      .call(user.id)
      .switchMap(
        (NormalizedBudgetEntity budget) => CombineLatestStream.combine2(
          Stream<NormalizedBudgetEntity>.value(budget),
          fetchBudgetAllocationsUseCase.call(userId: user.id, budgetId: budget.id),
          _deriveState,
        ),
      )
      .distinct();
}

class ActiveBudgetState with EquatableMixin {
  const ActiveBudgetState({
    required this.budget,
    required this.categories,
  });

  final ActiveBudgetViewModel budget;
  final List<ActiveBudgetCategoryViewModel> categories;

  @override
  List<Object> get props => <Object>[budget, categories];
}

ActiveBudgetState _deriveState(
  NormalizedBudgetEntity budget,
  NormalizedBudgetAllocationEntityList allocations,
) {
  final Map<String, NormalizedBudgetAllocationEntity> allocationByPlan = allocations.foldToMap((_) => _.plan.id);
  final Map<String, int> allocationByCategory = budget.plans.groupFoldBy<String, int>(
    (_) => _.category.id,
    (int? previous, NormalizedBudgetPlanEntity plan) => (previous ?? 0) + (allocationByPlan[plan.id]?.amount ?? 0),
  );
  final Iterable<ActiveBudgetCategoryViewModel> categories =
      budget.plans.uniqueBy((_) => _.category.id).map((_) => _.category).map(
            (BudgetCategoryEntity category) => ActiveBudgetCategoryViewModel(
              id: category.id,
              path: category.path,
              title: category.title,
              allocation: Money(allocationByCategory[category.id] ?? 0),
              description: category.description,
              color: Color(category.color),
              createdAt: category.createdAt,
              updatedAt: category.updatedAt,
            ),
          );
  final Map<String, ActiveBudgetCategoryViewModel> categoriesById = categories.foldToMap((_) => _.id);
  final Iterable<ActiveBudgetPlanViewModel> plans = budget.plans.map(
    (NormalizedBudgetPlanEntity plan) {
      final NormalizedBudgetAllocationEntity? allocation = allocationByPlan[plan.id];
      return ActiveBudgetPlanViewModel(
        id: plan.id,
        path: plan.path,
        title: plan.title,
        allocation: allocation?.toViewModel(),
        description: plan.description,
        category: categoriesById[plan.category.id]!,
        createdAt: plan.createdAt,
        updatedAt: plan.updatedAt,
      );
    },
  );

  return ActiveBudgetState(
    budget: ActiveBudgetViewModel(
      id: budget.id,
      path: budget.path,
      title: budget.title,
      amount: Money(budget.amount),
      allocation: Money(allocationByCategory.values.reduce((int value, int current) => value + current)),
      description: budget.description,
      plans: plans.sorted((ActiveBudgetPlanViewModel a, ActiveBudgetPlanViewModel b) {
        final Money? moneyA = a.allocation?.amount;
        final Money? moneyB = b.allocation?.amount;
        if (moneyA != null && moneyB != null) {
          return moneyB.compareTo(moneyA);
        }

        return 0;
      }),
      startedAt: budget.startedAt,
      endedAt: budget.endedAt,
      createdAt: budget.createdAt,
      updatedAt: budget.updatedAt,
    ),
    categories: categories.toList(growable: false),
  );
}

extension on NormalizedBudgetAllocationEntity {
  BudgetAllocationViewModel toViewModel() => BudgetAllocationViewModel(
        id: id,
        path: path,
        amount: Money(amount),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
