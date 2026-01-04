// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetPlans)
final budgetPlansProvider = BudgetPlansProvider._();

final class BudgetPlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BudgetPlanViewModel>>,
          List<BudgetPlanViewModel>,
          Stream<List<BudgetPlanViewModel>>
        >
    with $FutureModifier<List<BudgetPlanViewModel>>, $StreamProvider<List<BudgetPlanViewModel>> {
  BudgetPlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetPlansProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          BudgetPlansProvider.$allTransitiveDependencies0,
          BudgetPlansProvider.$allTransitiveDependencies1,
          BudgetPlansProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetPlansHash();

  @$internal
  @override
  $StreamProviderElement<List<BudgetPlanViewModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BudgetPlanViewModel>> create(Ref ref) {
    return budgetPlans(ref);
  }
}

String _$budgetPlansHash() => r'd2376dd29e37c9338640b1654a583c5e338136d6';
