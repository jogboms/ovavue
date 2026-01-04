// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Preferences)
final preferencesProvider = PreferencesProvider._();

final class PreferencesProvider extends $AsyncNotifierProvider<Preferences, PreferencesState> {
  PreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, accountProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          PreferencesProvider.$allTransitiveDependencies0,
          PreferencesProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = accountProvider;

  @override
  String debugGetCreateSourceHash() => _$preferencesHash();

  @$internal
  @override
  Preferences create() => Preferences();
}

String _$preferencesHash() => r'7e33c9a814985b980a424a6b4bc416ec94d8d29c';

abstract class _$Preferences extends $AsyncNotifier<PreferencesState> {
  FutureOr<PreferencesState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PreferencesState>, PreferencesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PreferencesState>, PreferencesState>,
              AsyncValue<PreferencesState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
