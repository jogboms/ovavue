// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(account)
final accountProvider = AccountProvider._();

final class AccountProvider
    extends $FunctionalProvider<AsyncValue<AccountEntity>, AccountEntity, FutureOr<AccountEntity>>
    with $FutureModifier<AccountEntity>, $FutureProvider<AccountEntity> {
  AccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          AccountProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;

  @override
  String debugGetCreateSourceHash() => _$accountHash();

  @$internal
  @override
  $FutureProviderElement<AccountEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AccountEntity> create(Ref ref) {
    return account(ref);
  }
}

String _$accountHash() => r'7b2fbd8bc18faa6338f422ce982001327fe3fc20';
