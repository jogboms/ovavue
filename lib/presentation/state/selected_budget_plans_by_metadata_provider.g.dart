// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_plans_by_metadata_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetPlansByMetadata)
const selectedBudgetPlansByMetadataProvider = SelectedBudgetPlansByMetadataFamily._();

final class SelectedBudgetPlansByMetadataProvider
    extends
        $FunctionalProvider<
          AsyncValue<BudgetPlansByMetadataState>,
          BudgetPlansByMetadataState,
          Stream<BudgetPlansByMetadataState>
        >
    with $FutureModifier<BudgetPlansByMetadataState>, $StreamProvider<BudgetPlansByMetadataState> {
  const SelectedBudgetPlansByMetadataProvider._({
    required SelectedBudgetPlansByMetadataFamily super.from,
    required ({String id, String? budgetId}) super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetPlansByMetadataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = budgetMetadataProvider;
  static const $allTransitiveDependencies4 = selectedBudgetProvider;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetPlansByMetadataHash();

  @override
  String toString() {
    return r'selectedBudgetPlansByMetadataProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<BudgetPlansByMetadataState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetPlansByMetadataState> create(Ref ref) {
    final argument = this.argument as ({String id, String? budgetId});
    return selectedBudgetPlansByMetadata(
      ref,
      id: argument.id,
      budgetId: argument.budgetId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetPlansByMetadataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetPlansByMetadataHash() => r'75ffba4915b3bd0392b334346d8b9124fe433db2';

final class SelectedBudgetPlansByMetadataFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BudgetPlansByMetadataState>, ({String id, String? budgetId})> {
  const SelectedBudgetPlansByMetadataFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetPlansByMetadataProvider',
        dependencies: const <ProviderOrFamily>[
          registryProvider,
          userProvider,
          budgetMetadataProvider,
          selectedBudgetProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies0,
          SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies1,
          SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies2,
          SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies3,
          SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  SelectedBudgetPlansByMetadataProvider call({
    required String id,
    required String? budgetId,
  }) => SelectedBudgetPlansByMetadataProvider._(
    argument: (id: id, budgetId: budgetId),
    from: this,
  );

  @override
  String toString() => r'selectedBudgetPlansByMetadataProvider';
}
