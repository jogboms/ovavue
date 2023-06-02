import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models.dart';
import 'registry_provider.dart';
import 'user_provider.dart';

part 'selected_budget_metadata_by_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetMetadataValueViewModel>> selectedBudgetMetadataByPlan(
  SelectedBudgetMetadataByPlanRef ref, {
  required String id,
}) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetMetadataByPlanUseCase>()
      .call(userId: user.id, planId: id)
      .map((_) => _.map(BudgetMetadataValueViewModel.fromEntity).toList(growable: false))
      .distinct();
}
