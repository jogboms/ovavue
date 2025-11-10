// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(user)
const userProvider = UserProvider._();

final class UserProvider extends $FunctionalProvider<AsyncValue<UserEntity>, UserEntity, FutureOr<UserEntity>>
    with $FutureModifier<UserEntity>, $FutureProvider<UserEntity> {
  const UserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          registryProvider,
          accountProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          UserProvider.$allTransitiveDependencies0,
          UserProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = accountProvider;

  @override
  String debugGetCreateSourceHash() => _$userHash();

  @$internal
  @override
  $FutureProviderElement<UserEntity> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserEntity> create(Ref ref) {
    return user(ref);
  }
}

String _$userHash() => r'19383c561f9c2e41c210fbeaa7ec3d84621eb895';
