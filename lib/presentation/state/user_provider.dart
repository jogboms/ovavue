import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/state/account_provider.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(dependencies: [registry, account])
Future<UserEntity> user(Ref ref) async {
  final registry = ref.read(registryProvider);
  final account = await ref.watch(accountProvider.future);

  final user = await registry.get<FetchUserUseCase>().call(account.id);
  if (user == null) {
    return registry.get<CreateUserUseCase>().call(account);
  }

  return user;
}
