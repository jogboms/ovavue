import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'models.dart';
part 'selected_budget_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgets, budgetPlans, selectedBudgetMetadataByPlan])
Stream<BudgetPlanState> selectedBudgetPlan(
  Ref ref, {
  required String id,
  required String? budgetId,
}) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  final plan = await ref.watch(
    budgetPlansProvider.selectAsync(
      (List<BudgetPlanViewModel> plans) => plans.firstWhereOrNull((BudgetPlanViewModel e) => e.id == id),
    ),
  );

  if (plan != null) {
    final budget = await ref.watch(
      budgetsProvider.selectAsync(
        (List<BudgetViewModel> budgets) => budgets.firstWhereOrNull((BudgetViewModel e) => e.id == budgetId),
      ),
    );

    final metadata = await ref.watch(
      selectedBudgetMetadataByPlanProvider(id: plan.id).future,
    );

    yield* registry
        .get<FetchBudgetAllocationsByPlanUseCase>()
        .call(userId: user.id, planId: id)
        .map(
          (BudgetAllocationEntityList allocations) => BudgetPlanState(
            plan: plan,
            metadata: metadata,
            budget: budget,
            allocation: allocations
                .firstWhereOrNull((BudgetAllocationEntity e) => e.budget.id == budgetId)
                ?.toViewModel(),
            previousAllocations: allocations
                .where((BudgetAllocationEntity e) => e.budget.id != budgetId)
                .map((BudgetAllocationEntity e) => (e.toViewModel(), BudgetViewModel.fromEntity(e.budget)))
                .sorted(
                  (BudgetPlanAllocationViewModel a, BudgetPlanAllocationViewModel b) =>
                      b.$2.startedAt.compareTo(a.$2.startedAt),
                )
                .toList(growable: false),
          ),
        )
        .distinct();
  }
}

class BudgetPlanState with EquatableMixin {
  const BudgetPlanState({
    required this.plan,
    required this.metadata,
    required this.budget,
    required this.allocation,
    required this.previousAllocations,
  });

  final BudgetPlanViewModel plan;
  final List<BudgetMetadataValueViewModel> metadata;
  final BudgetViewModel? budget;
  final BudgetAllocationViewModel? allocation;
  final List<BudgetPlanAllocationViewModel> previousAllocations;

  @override
  List<Object?> get props => <Object?>[plan, metadata, budget, allocation, previousAllocations];
}
