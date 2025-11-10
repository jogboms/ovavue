// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_budget_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeBudgetId)
const activeBudgetIdProvider = ActiveBudgetIdProvider._();

final class ActiveBudgetIdProvider extends $FunctionalProvider<AsyncValue<String?>, String?, Stream<String?>>
    with $FutureModifier<String?>, $StreamProvider<String?> {
  const ActiveBudgetIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeBudgetIdProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          ActiveBudgetIdProvider.$allTransitiveDependencies0,
          ActiveBudgetIdProvider.$allTransitiveDependencies1,
          ActiveBudgetIdProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$activeBudgetIdHash();

  @$internal
  @override
  $StreamProviderElement<String?> $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<String?> create(Ref ref) {
    return activeBudgetId(ref);
  }
}

String _$activeBudgetIdHash() => r'796f0c048ac0720237f0f02a89e822dca8472e79';
