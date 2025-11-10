import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_plans_by_budget_metadata.g.dart';

@Riverpod(dependencies: <Object>[selectedBudgetPlansByMetadata])
Future<BaseBudgetPlansByMetadataState> filterPlansByBudgetMetadata(
  FilterPlansByBudgetMetadataRef ref, {
  required String budgetId,
}) async {
  final metadataId = ref.watch(filterMetadataIdProvider);
  if (metadataId == null) {
    return BaseBudgetPlansByMetadataState.empty;
  }

  return ref.watch(selectedBudgetPlansByMetadataProvider(id: metadataId, budgetId: budgetId).future);
}

@riverpod
class FilterMetadataId extends _$FilterMetadataId {
  @override
  String? build() => null;

  // ignore: use_setters_to_change_properties
  void setState(String? id) => state = id;
}
