// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetCategories)
const budgetCategoriesProvider = BudgetCategoriesProvider._();

final class BudgetCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BudgetCategoryViewModel>>,
          List<BudgetCategoryViewModel>,
          Stream<List<BudgetCategoryViewModel>>
        >
    with $FutureModifier<List<BudgetCategoryViewModel>>, $StreamProvider<List<BudgetCategoryViewModel>> {
  const BudgetCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetCategoriesProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          BudgetCategoriesProvider.$allTransitiveDependencies0,
          BudgetCategoriesProvider.$allTransitiveDependencies1,
          BudgetCategoriesProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetCategoriesHash();

  @$internal
  @override
  $StreamProviderElement<List<BudgetCategoryViewModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BudgetCategoryViewModel>> create(Ref ref) {
    return budgetCategories(ref);
  }
}

String _$budgetCategoriesHash() => r'a35f2cd76feb2909a129d0003c9bb9778dd17ee9';
