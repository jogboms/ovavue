// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budgets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgets)
final budgetsProvider = BudgetsProvider._();

final class BudgetsProvider
    extends $FunctionalProvider<AsyncValue<List<BudgetViewModel>>, List<BudgetViewModel>, Stream<List<BudgetViewModel>>>
    with $FutureModifier<List<BudgetViewModel>>, $StreamProvider<List<BudgetViewModel>> {
  BudgetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetsProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          BudgetsProvider.$allTransitiveDependencies0,
          BudgetsProvider.$allTransitiveDependencies1,
          BudgetsProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetsHash();

  @$internal
  @override
  $StreamProviderElement<List<BudgetViewModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BudgetViewModel>> create(Ref ref) {
    return budgets(ref);
  }
}

String _$budgetsHash() => r'b5b28d141f009a784325f8b6d4e6991f318ece1c';
