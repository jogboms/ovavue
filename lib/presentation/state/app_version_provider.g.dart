// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Container for the application's version
/// Should be overridden per [ProviderScope]

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// Container for the application's version
/// Should be overridden per [ProviderScope]

final class AppVersionProvider extends $FunctionalProvider<String, String, String> with $Provider<String> {
  /// Container for the application's version
  /// Should be overridden per [ProviderScope]
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appVersion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appVersionHash() => r'dcccb89ddec32b8509fb12490145c3668f1f9017';
