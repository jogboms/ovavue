// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_category_by_budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetCategoryByBudget)
final selectedBudgetCategoryByBudgetProvider = SelectedBudgetCategoryByBudgetFamily._();

final class SelectedBudgetCategoryByBudgetProvider
    extends $FunctionalProvider<AsyncValue<BudgetCategoryState>, BudgetCategoryState, Stream<BudgetCategoryState>>
    with $FutureModifier<BudgetCategoryState>, $StreamProvider<BudgetCategoryState> {
  SelectedBudgetCategoryByBudgetProvider._({
    required SelectedBudgetCategoryByBudgetFamily super.from,
    required ({String id, String budgetId}) super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetCategoryByBudgetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = budgetsProvider;
  static final $allTransitiveDependencies4 = budgetPlansProvider;
  static final $allTransitiveDependencies5 = budgetCategoriesProvider;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetCategoryByBudgetHash();

  @override
  String toString() {
    return r'selectedBudgetCategoryByBudgetProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<BudgetCategoryState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetCategoryState> create(Ref ref) {
    final argument = this.argument as ({String id, String budgetId});
    return selectedBudgetCategoryByBudget(
      ref,
      id: argument.id,
      budgetId: argument.budgetId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetCategoryByBudgetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetCategoryByBudgetHash() => r'747115c3774109c1d3dc1164b57bd7883cd6c262';

final class SelectedBudgetCategoryByBudgetFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetCategoryState>, ({String id, String budgetId})> {
  SelectedBudgetCategoryByBudgetFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetCategoryByBudgetProvider',
        dependencies: <ProviderOrFamily>[
          registryProvider,
          userProvider,
          budgetsProvider,
          budgetPlansProvider,
          budgetCategoriesProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies0,
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies1,
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies2,
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies3,
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies4,
          SelectedBudgetCategoryByBudgetProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  SelectedBudgetCategoryByBudgetProvider call({
    required String id,
    required String budgetId,
  }) => SelectedBudgetCategoryByBudgetProvider._(
    argument: (id: id, budgetId: budgetId),
    from: this,
  );

  @override
  String toString() => r'selectedBudgetCategoryByBudgetProvider';
}
