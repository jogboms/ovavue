// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetCategory)
final budgetCategoryProvider = BudgetCategoryProvider._();

final class BudgetCategoryProvider
    extends $FunctionalProvider<BudgetCategoryProviderState, BudgetCategoryProviderState, BudgetCategoryProviderState>
    with $Provider<BudgetCategoryProviderState> {
  BudgetCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetCategoryProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          BudgetCategoryProvider.$allTransitiveDependencies0,
          BudgetCategoryProvider.$allTransitiveDependencies1,
          BudgetCategoryProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetCategoryHash();

  @$internal
  @override
  $ProviderElement<BudgetCategoryProviderState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetCategoryProviderState create(Ref ref) {
    return budgetCategory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetCategoryProviderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetCategoryProviderState>(value),
    );
  }
}

String _$budgetCategoryHash() => r'a325f68edc10bfedcd828eaf5db5a4270c4e014b';
