// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budget)
final budgetProvider = BudgetProvider._();

final class BudgetProvider extends $FunctionalProvider<BudgetProviderState, BudgetProviderState, BudgetProviderState>
    with $Provider<BudgetProviderState> {
  BudgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          registryProvider,
          userProvider,
          activeBudgetProvider,
          selectedBudgetProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          BudgetProvider.$allTransitiveDependencies0,
          BudgetProvider.$allTransitiveDependencies1,
          BudgetProvider.$allTransitiveDependencies2,
          BudgetProvider.$allTransitiveDependencies3,
          BudgetProvider.$allTransitiveDependencies4,
          BudgetProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = activeBudgetProvider;
  static final $allTransitiveDependencies4 = ActiveBudgetProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies5 = ActiveBudgetProvider.$allTransitiveDependencies4;

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
