// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetCategory)
const selectedBudgetCategoryProvider = SelectedBudgetCategoryFamily._();

final class SelectedBudgetCategoryProvider
    extends $FunctionalProvider<AsyncValue<BudgetCategoryState>, BudgetCategoryState, Stream<BudgetCategoryState>>
    with $FutureModifier<BudgetCategoryState>, $StreamProvider<BudgetCategoryState> {
  const SelectedBudgetCategoryProvider._({
    required SelectedBudgetCategoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = budgetPlansProvider;
  static const $allTransitiveDependencies1 = BudgetPlansProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = BudgetPlansProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = BudgetPlansProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 = budgetCategoriesProvider;

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

String _$selectedBudgetCategoryHash() => r'1c7dbd09cc50bea74ea5c9e186511e7f87a6547e';

final class SelectedBudgetCategoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetCategoryState>, String> {
  const SelectedBudgetCategoryFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetCategoryProvider',
        dependencies: const <ProviderOrFamily>[
          budgetPlansProvider,
          budgetCategoriesProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
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
