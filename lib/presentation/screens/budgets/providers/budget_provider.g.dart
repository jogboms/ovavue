// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budget)
const budgetProvider = BudgetProvider._();

final class BudgetProvider extends $FunctionalProvider<BudgetProviderState, BudgetProviderState, BudgetProviderState>
    with $Provider<BudgetProviderState> {
  const BudgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          registryProvider,
          userProvider,
          activeBudgetProvider,
          selectedBudgetProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          BudgetProvider.$allTransitiveDependencies0,
          BudgetProvider.$allTransitiveDependencies1,
          BudgetProvider.$allTransitiveDependencies2,
          BudgetProvider.$allTransitiveDependencies3,
          BudgetProvider.$allTransitiveDependencies4,
          BudgetProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = activeBudgetProvider;
  static const $allTransitiveDependencies4 = ActiveBudgetProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies5 = ActiveBudgetProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$budgetHash();

  @$internal
  @override
  $ProviderElement<BudgetProviderState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetProviderState create(Ref ref) {
    return budget(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetProviderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetProviderState>(value),
    );
  }
}

String _$budgetHash() => r'296b269b33de7720e211a2eb7df09963dbe7c45b';
