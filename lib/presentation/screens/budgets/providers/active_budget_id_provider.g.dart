// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_budget_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeBudgetId)
final activeBudgetIdProvider = ActiveBudgetIdProvider._();

final class ActiveBudgetIdProvider extends $FunctionalProvider<AsyncValue<String?>, String?, Stream<String?>>
    with $FutureModifier<String?>, $StreamProvider<String?> {
  ActiveBudgetIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeBudgetIdProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ActiveBudgetIdProvider.$allTransitiveDependencies0,
          ActiveBudgetIdProvider.$allTransitiveDependencies1,
          ActiveBudgetIdProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

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
