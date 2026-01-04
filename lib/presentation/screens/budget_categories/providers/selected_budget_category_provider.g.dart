// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetCategory)
final selectedBudgetCategoryProvider = SelectedBudgetCategoryFamily._();

final class SelectedBudgetCategoryProvider
    extends $FunctionalProvider<AsyncValue<BudgetCategoryState>, BudgetCategoryState, Stream<BudgetCategoryState>>
    with $FutureModifier<BudgetCategoryState>, $StreamProvider<BudgetCategoryState> {
  SelectedBudgetCategoryProvider._({
    required SelectedBudgetCategoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = budgetPlansProvider;
  static final $allTransitiveDependencies1 = BudgetPlansProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = BudgetPlansProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = BudgetPlansProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = budgetCategoriesProvider;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetCategoryHash();

  @override
  String toString() {
    return r'selectedBudgetCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<BudgetCategoryState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetCategoryState> create(Ref ref) {
    final argument = this.argument as String;
    return selectedBudgetCategory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetCategoryHash() => r'3055ed03fe756bf8835974878c7799ee495597da';

final class SelectedBudgetCategoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetCategoryState>, String> {
  SelectedBudgetCategoryFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetCategoryProvider',
        dependencies: <ProviderOrFamily>[
          budgetPlansProvider,
          budgetCategoriesProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          SelectedBudgetCategoryProvider.$allTransitiveDependencies0,
          SelectedBudgetCategoryProvider.$allTransitiveDependencies1,
          SelectedBudgetCategoryProvider.$allTransitiveDependencies2,
          SelectedBudgetCategoryProvider.$allTransitiveDependencies3,
          SelectedBudgetCategoryProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  SelectedBudgetCategoryProvider call(String id) => SelectedBudgetCategoryProvider._(argument: id, from: this);

  @override
  String toString() => r'selectedBudgetCategoryProvider';
}
