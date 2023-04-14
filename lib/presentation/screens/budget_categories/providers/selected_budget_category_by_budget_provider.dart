import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/streams.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';
import 'models.dart';

export 'models.dart';

part 'selected_budget_category_by_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgetCategories])
Stream<BudgetCategoryByBudgetState> selectedBudgetCategoryByBudget(
  SelectedBudgetCategoryByBudgetRef ref, {
  required String id,
  required String budgetId,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final List<BudgetCategoryViewModel> budgetCategories = await ref.watch(budgetCategoriesProvider.future);
  final BudgetCategoryViewModel category = budgetCategories.firstWhere((_) => _.id == id);

  yield* CombineLatestStream.combine3(
    registry.get<FetchBudgetUseCase>().call(userId: user.id, budgetId: budgetId),
    registry.get<FetchBudgetPlansByCategoryUseCase>().call(userId: user.id, categoryId: id),
    registry.get<FetchBudgetAllocationsUseCase>().call(userId: user.id, budgetId: budgetId),
    (
      NormalizedBudgetEntity budget,
      NormalizedBudgetPlanEntityList budgetPlans,
      NormalizedBudgetAllocationEntityList allocations,
    ) {
      final Map<String, NormalizedBudgetAllocationEntity> allocationsByPlan = allocations.foldToMap((_) => _.plan.id);
      final List<BudgetCategoryPlanViewModel> plans = budgetPlans
          .map(
            (NormalizedBudgetPlanEntity element) => BudgetCategoryPlanViewModel(
              id: element.id,
              path: element.path,
              title: element.title,
              description: element.description,
              allocation: allocationsByPlan[element.id]?.amount.asMoney,
            ),
          )
          .sorted(
            (
              BudgetCategoryPlanViewModel a,
              BudgetCategoryPlanViewModel b,
            ) =>
                b.allocation?.compareTo(a.allocation ?? Money.zero) ?? 1,
          )
          .toList(growable: false);

      return BudgetCategoryByBudgetState(
        category: category,
        allocation: plans.map((_) => _.allocation).whereNotNull().sum(),
        budget: BudgetCategoryBudgetViewModel(
          id: budget.id,
          path: budget.path,
          amount: Money(budget.amount),
        ),
        plans: plans,
      );
    },
  ).distinct();
}

class BudgetCategoryByBudgetState with EquatableMixin {
  const BudgetCategoryByBudgetState({
    required this.category,
    required this.allocation,
    required this.budget,
    required this.plans,
  });

  final BudgetCategoryViewModel category;
  final Money allocation;
  final BudgetCategoryBudgetViewModel budget;
  final List<BudgetCategoryPlanViewModel> plans;

  @override
  List<Object?> get props => <Object?>[category, allocation, budget, plans];
}
