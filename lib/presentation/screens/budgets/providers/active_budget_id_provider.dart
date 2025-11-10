import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_budget_id_provider.g.dart';

@Riverpod(dependencies: [registry, user])
Stream<String?> activeBudgetId(Ref ref) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry.get<FetchActiveBudgetUseCase>().call(user.id).map((BudgetEntity? e) => e?.id).distinct();
}
