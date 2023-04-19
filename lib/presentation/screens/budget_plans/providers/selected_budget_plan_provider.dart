import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart' hide BudgetAllocationViewModelExtension;
import '../../../state.dart';
import '../../../utils.dart';

part 'models.dart';
part 'selected_budget_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgets, budgetPlans])
Stream<BudgetPlanState> selectedBudgetPlan(
  SelectedBudgetPlanRef ref, {
  required String id,
  required String? budgetId,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final BudgetPlanViewModel plan = await ref.watch(
    budgetPlansProvider.selectAsync(
      (List<BudgetPlanViewModel> plans) => plans.firstWhere((_) => _.id == id),
    ),
  );
  final BudgetViewModel? budget = await ref.watch(
    budgetsProvider.selectAsync(
      (List<BudgetViewModel> budgets) => budgets.firstWhereOrNull((_) => _.id == budgetId),
    ),
  );

  yield* registry
      .get<FetchBudgetAllocationsByPlanUseCase>()
      .call(userId: user.id, planId: id)
      .map(
        (NormalizedBudgetAllocationEntityList allocations) => BudgetPlanState(
          plan: plan,
          budget: budget,
          allocation: allocations.singleWhereOrNull((_) => _.budget.id == budgetId)?.toViewModel(),
          previousAllocations: allocations
              .where((_) => _.budget.id != budgetId)
              .map((_) => _.toViewModel())
              .sorted(
                (
                  BudgetPlanAllocationViewModel a,
                  BudgetPlanAllocationViewModel b,
                ) =>
                    b.budget.startedAt.compareTo(a.budget.startedAt),
              )
              .toList(),
        ),
      )
      .distinct();
}

class BudgetPlanState with EquatableMixin {
  const BudgetPlanState({
    required this.plan,
    required this.budget,
    required this.allocation,
    required this.previousAllocations,
  });

  final BudgetPlanViewModel plan;
  final BudgetViewModel? budget;
  final BudgetPlanAllocationViewModel? allocation;
  final List<BudgetPlanAllocationViewModel> previousAllocations;

  @override
  List<Object?> get props => <Object?>[plan, budget, allocation, previousAllocations];
}
