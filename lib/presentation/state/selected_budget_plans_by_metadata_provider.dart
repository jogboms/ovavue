import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state/budget_metadata_provider.dart';
import 'package:ovavue/presentation/state/budget_plans_by_metadata_state.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:ovavue/presentation/state/selected_budget_provider.dart';
import 'package:ovavue/presentation/state/user_provider.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_budget_plans_by_metadata_provider.g.dart';

@Riverpod(dependencies: [registry, user, BudgetMetadata, selectedBudget])
Stream<BudgetPlansByMetadataState> selectedBudgetPlansByMetadata(
  Ref ref, {
  required String id,
  required String? budgetId,
}) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  final metadata = await ref.watch(
    budgetMetadataProvider.selectAsync(
      (List<BudgetMetadataViewModel> e) => e.firstWhereOrNull(
        (BudgetMetadataViewModel e) => e.values.map((BudgetMetadataValueViewModel e) => e.id).contains(id),
      ),
    ),
  );

  if (metadata != null) {
    final budgetState = budgetId == null ? null : await ref.watch(selectedBudgetProvider(budgetId).future);
    final budgetPlansById = budgetState?.plans.foldToMap(
      (BudgetPlanViewModel e) => e.id,
    );

    yield* registry
        .get<FetchBudgetPlansByMetadataUseCase>()
        .call(userId: user.id, metadataId: id)
        .map(
          (BudgetPlanEntityList plans) => BudgetPlansByMetadataState(
            budget: budgetState?.budget,
            allocation: budgetState?.allocation,
            key: metadata.key,
            metadata: metadata.values.firstWhere((BudgetMetadataValueViewModel e) => e.id == id),
            plans: plans
                .map(
                  (BudgetPlanEntity plan) => budgetId != null && budgetPlansById != null
                      ? budgetPlansById[plan.id]
                      : BudgetPlanViewModel.fromEntity(plan),
                )
                .whereType<BudgetPlanViewModel>()
                .sortedByMoney(),
          ),
        );
  }
}
