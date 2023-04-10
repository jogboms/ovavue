import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';

part 'models.dart';
part 'selected_budget_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgetPlans])
Stream<BudgetPlanState> selectedBudgetPlan(
  SelectedBudgetPlanRef ref, {
  required String id,
  required String? budgetId,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final List<BudgetPlanViewModel> plans = await ref.watch(budgetPlansProvider.future);
  final BudgetPlanViewModel plan = plans.firstWhere((BudgetPlanViewModel element) => element.id == id);

  yield* registry.get<FetchBudgetAllocationsByPlanUseCase>().call(userId: user.id, planId: id).map(
        (NormalizedBudgetAllocationEntityList allocations) => BudgetPlanState(
          plan: plan,
          allocation: allocations.singleWhereOrNull((_) => _.budget.id == budgetId)?.toViewModel(),
          previousAllocations: allocations.where((_) => _.budget.id != budgetId).map((_) => _.toViewModel()).toList(),
        ),
      );
}

class BudgetPlanState with EquatableMixin {
  const BudgetPlanState({
    required this.plan,
    required this.allocation,
    required this.previousAllocations,
  });

  final BudgetPlanViewModel plan;
  final BudgetPlanAllocationViewModel? allocation;
  final List<BudgetPlanAllocationViewModel> previousAllocations;

  @override
  List<Object?> get props => <Object?>[plan, allocation, previousAllocations];
}
