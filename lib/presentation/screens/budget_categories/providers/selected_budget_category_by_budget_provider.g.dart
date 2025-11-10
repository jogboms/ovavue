// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_category_by_budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetCategoryByBudget)
const selectedBudgetCategoryByBudgetProvider = SelectedBudgetCategoryByBudgetFamily._();

final class SelectedBudgetCategoryByBudgetProvider
    extends $FunctionalProvider<AsyncValue<BudgetCategoryState>, BudgetCategoryState, Stream<BudgetCategoryState>>
    with $FutureModifier<BudgetCategoryState>, $StreamProvider<BudgetCategoryState> {
  const SelectedBudgetCategoryByBudgetProvider._({
    required SelectedBudgetCategoryByBudgetFamily super.from,
    required ({String id, String budgetId}) super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetCategoryByBudgetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = budgetsProvider;
  static const $allTransitiveDependencies4 = budgetPlansProvider;
  static const $allTransitiveDependencies5 = budgetCategoriesProvider;

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

String _$selectedBudgetCategoryByBudgetHash() => r'0c604052e84560a54fe98aefa39c9b99ba36a801';

final class SelectedBudgetCategoryByBudgetFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetCategoryState>, ({String id, String budgetId})> {
  const SelectedBudgetCategoryByBudgetFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetCategoryByBudgetProvider',
        dependencies: const <ProviderOrFamily>[
          registryProvider,
          userProvider,
          budgetsProvider,
          budgetPlansProvider,
          budgetCategoriesProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
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
