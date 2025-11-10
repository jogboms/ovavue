// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetPlan)
const budgetPlanProvider = BudgetPlanProvider._();

final class BudgetPlanProvider
    extends $FunctionalProvider<BudgetPlanProviderState, BudgetPlanProviderState, BudgetPlanProviderState>
    with $Provider<BudgetPlanProviderState> {
  const BudgetPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetPlanProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          BudgetPlanProvider.$allTransitiveDependencies0,
          BudgetPlanProvider.$allTransitiveDependencies1,
          BudgetPlanProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetPlanHash();

  @$internal
  @override
  $ProviderElement<BudgetPlanProviderState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetPlanProviderState create(Ref ref) {
    return budgetPlan(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetPlanProviderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetPlanProviderState>(value),
    );
  }
}

String _$budgetPlanHash() => r'e97b1817d48fab1ee1704730bf61543527339a3e';
