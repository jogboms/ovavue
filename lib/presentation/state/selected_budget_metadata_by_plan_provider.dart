import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:ovavue/presentation/state/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_budget_metadata_by_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetMetadataValueViewModel>> selectedBudgetMetadataByPlan(
  Ref ref, {
  required String id,
}) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetMetadataByPlanUseCase>()
      .call(userId: user.id, planId: id)
      .map((BudgetMetadataValueEntityList e) => e.map(BudgetMetadataValueViewModel.fromEntity).toList(growable: false))
      .distinct();
}
