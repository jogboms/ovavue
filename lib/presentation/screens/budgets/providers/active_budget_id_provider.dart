import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../state.dart';

part 'active_budget_id_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<String?> activeBudgetId(ActiveBudgetIdRef ref) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry.get<FetchActiveBudgetUseCase>().call(user.id).map((_) => _?.id).distinct();
}
