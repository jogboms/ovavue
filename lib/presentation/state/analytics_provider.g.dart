// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Should only be used from the UI

@ProviderFor(analytics)
const analyticsProvider = AnalyticsProvider._();

/// Should only be used from the UI

final class AnalyticsProvider extends $FunctionalProvider<Analytics, Analytics, Analytics> with $Provider<Analytics> {
  /// Should only be used from the UI
  const AnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[registryProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AnalyticsProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = registryProvider;

  @override
  String debugGetCreateSourceHash() => _$analyticsHash();

  @$internal
  @override
  $ProviderElement<Analytics> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Analytics create(Ref ref) {
    return analytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Analytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Analytics>(value),
    );
  }
}

String _$analyticsHash() => r'96b16fa9ff8f4dc9f72ac802fd30b8e0a9977a26';
