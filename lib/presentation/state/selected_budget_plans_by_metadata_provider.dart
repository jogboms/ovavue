import 'package:collection/collection.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models.dart';
import '../utils.dart';
import 'budget_metadata_provider.dart';
import 'budget_plans_by_metadata_state.dart';
import 'budget_state.dart';
import 'registry_provider.dart';
import 'selected_budget_provider.dart';
import 'user_provider.dart';

part 'selected_budget_plans_by_metadata_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, BudgetMetadata, selectedBudget])
Stream<BudgetPlansByMetadataState> selectedBudgetPlansByMetadata(
  SelectedBudgetPlansByMetadataRef ref, {
  required String id,
  required String? budgetId,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final BudgetMetadataViewModel? metadata = await ref.watch(
    budgetMetadataProvider.selectAsync(
      (_) => _.firstWhereOrNull((_) => _.values.map((_) => _.id).contains(id)),
    ),
  );

  if (metadata != null) {
    final BudgetState? budgetState = budgetId == null ? null : await ref.watch(selectedBudgetProvider(budgetId).future);
    final Map<String, BudgetPlanViewModel>? budgetPlansById = budgetState?.plans.foldToMap((_) => _.id);

    yield* registry.get<FetchBudgetPlansByMetadataUseCase>().call(userId: user.id, metadataId: id).map(
          (BudgetPlanEntityList plans) => BudgetPlansByMetadataState(
            budget: budgetState?.budget,
            allocation: budgetState?.allocation,
            key: metadata.key,
            metadata: metadata.values.firstWhere((_) => _.id == id),
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
