// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetPlan)
final selectedBudgetPlanProvider = SelectedBudgetPlanFamily._();

final class SelectedBudgetPlanProvider
    extends $FunctionalProvider<AsyncValue<BudgetPlanState>, BudgetPlanState, Stream<BudgetPlanState>>
    with $FutureModifier<BudgetPlanState>, $StreamProvider<BudgetPlanState> {
  SelectedBudgetPlanProvider._({
    required SelectedBudgetPlanFamily super.from,
    required ({String id, String? budgetId}) super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetPlanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = budgetsProvider;
  static final $allTransitiveDependencies4 = budgetPlansProvider;
  static final $allTransitiveDependencies5 = selectedBudgetMetadataByPlanProvider;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetPlanHash();

  @override
  String toString() {
    return r'selectedBudgetPlanProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<BudgetPlanState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetPlanState> create(Ref ref) {
    final argument = this.argument as ({String id, String? budgetId});
    return selectedBudgetPlan(
      ref,
      id: argument.id,
      budgetId: argument.budgetId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetPlanHash() => r'99a16df060cca9f1156cbcd32eb4f41a17f0fc39';

final class SelectedBudgetPlanFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetPlanState>, ({String id, String? budgetId})> {
  SelectedBudgetPlanFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetPlanProvider',
        dependencies: <ProviderOrFamily>[
          registryProvider,
          userProvider,
          budgetsProvider,
          budgetPlansProvider,
          selectedBudgetMetadataByPlanProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          SelectedBudgetPlanProvider.$allTransitiveDependencies0,
          SelectedBudgetPlanProvider.$allTransitiveDependencies1,
          SelectedBudgetPlanProvider.$allTransitiveDependencies2,
          SelectedBudgetPlanProvider.$allTransitiveDependencies3,
          SelectedBudgetPlanProvider.$allTransitiveDependencies4,
          SelectedBudgetPlanProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  SelectedBudgetPlanProvider call({
    required String id,
    required String? budgetId,
  }) => SelectedBudgetPlanProvider._(
    argument: (id: id, budgetId: budgetId),
    from: this,
  );

  @override
  String toString() => r'selectedBudgetPlanProvider';
}
