// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_client_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Container for the backup client controller
/// Should be overridden per [ProviderScope]

@ProviderFor(backupClientController)
const backupClientControllerProvider = BackupClientControllerProvider._();

/// Container for the backup client controller
/// Should be overridden per [ProviderScope]

final class BackupClientControllerProvider
    extends $FunctionalProvider<BackupClientController, BackupClientController, BackupClientController>
    with $Provider<BackupClientController> {
  /// Container for the backup client controller
  /// Should be overridden per [ProviderScope]
  const BackupClientControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupClientControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$backupClientControllerHash();

  @$internal
  @override
  $ProviderElement<BackupClientController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupClientController create(Ref ref) {
    return backupClientController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupClientController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupClientController>(value),
    );
  }
}

String _$backupClientControllerHash() => r'9f8880f5890e04b0a4f6b58460919ddbb30129c5';
