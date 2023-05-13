import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../state.dart';

part 'preferences_provider.g.dart';

@Riverpod(dependencies: <Object>[registry])
class Preferences extends _$Preferences {
  @override
  Future<PreferencesState> build() async {
    final RegistryFactory di = ref.read(registryProvider).get;

    return PreferencesState(
      databaseLocation: await di<FetchDatabaseLocationUseCase>().call(),
    );
  }
}

class PreferencesState with EquatableMixin {
  const PreferencesState({
    required this.databaseLocation,
  });

  final String databaseLocation;

  @override
  List<Object> get props => <Object>[databaseLocation];
}
