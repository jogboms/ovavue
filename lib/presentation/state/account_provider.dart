import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_provider.g.dart';

@Riverpod(dependencies: <Object>[registry])
Future<AccountEntity> account(AccountRef ref) async => ref.read(registryProvider).get<FetchAccountUseCase>().call();
