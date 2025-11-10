// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Container for Registry/Service locator
/// Should be overridden per [ProviderScope]

@ProviderFor(registry)
const registryProvider = RegistryProvider._();

/// Container for Registry/Service locator
/// Should be overridden per [ProviderScope]

final class RegistryProvider extends $FunctionalProvider<Registry, Registry, Registry> with $Provider<Registry> {
  /// Container for Registry/Service locator
  /// Should be overridden per [ProviderScope]
  const RegistryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registryProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$registryHash();

  @$internal
  @override
  $ProviderElement<Registry> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Registry create(Ref ref) {
    return registry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Registry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Registry>(value),
    );
  }
}

String _$registryHash() => r'0d642992ef70c4e28697600cf9ed1f4a5e82eadc';
