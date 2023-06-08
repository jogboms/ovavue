import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state.dart';

part 'preferences_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, account])
class Preferences extends _$Preferences {
  @override
  Future<PreferencesState> build() async {
    final RegistryFactory di = ref.read(registryProvider).get;
    final AccountEntity account = await ref.watch(accountProvider.future);
    final int? themeMode = await di<FetchThemeModeUseCase>().call();

    return PreferencesState(
      accountKey: account.id,
      databaseLocation: await di<FetchDatabaseLocationUseCase>().call(),
      themeMode: themeMode != null ? ThemeMode.values[themeMode] : ThemeMode.system,
    );
  }

  Future<bool> importDatabase() async => ref.read(registryProvider).get<ImportDatabaseUseCase>().call();

  Future<bool> exportDatabase() async => ref.read(registryProvider).get<ExportDatabaseUseCase>().call();

  Future<bool> updateThemeMode(ThemeMode themeMode) async {
    ref.invalidateSelf();
    return ref.read(registryProvider).get<UpdateThemeModeUseCase>().call(themeMode.index);
  }
}

class PreferencesState with EquatableMixin {
  const PreferencesState({
    required this.accountKey,
    required this.databaseLocation,
    required this.themeMode,
  });

  final String accountKey;
  final String databaseLocation;
  final ThemeMode themeMode;

  @override
  List<Object> get props => <Object>[accountKey, databaseLocation, themeMode];
}
