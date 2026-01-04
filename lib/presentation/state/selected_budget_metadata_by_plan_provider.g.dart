// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_metadata_by_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudgetMetadataByPlan)
final selectedBudgetMetadataByPlanProvider = SelectedBudgetMetadataByPlanFamily._();

final class SelectedBudgetMetadataByPlanProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BudgetMetadataValueViewModel>>,
          List<BudgetMetadataValueViewModel>,
          Stream<List<BudgetMetadataValueViewModel>>
        >
    with $FutureModifier<List<BudgetMetadataValueViewModel>>, $StreamProvider<List<BudgetMetadataValueViewModel>> {
  SelectedBudgetMetadataByPlanProvider._({
    required SelectedBudgetMetadataByPlanFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetMetadataByPlanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetMetadataByPlanHash();

  @override
  String toString() {
    return r'selectedBudgetMetadataByPlanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<BudgetMetadataValueViewModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BudgetMetadataValueViewModel>> create(Ref ref) {
    final argument = this.argument as String;
    return selectedBudgetMetadataByPlan(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetMetadataByPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetMetadataByPlanHash() => r'e227fefe564ee2a074ce4c21d9d48cd6662c9023';

final class SelectedBudgetMetadataByPlanFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<BudgetMetadataValueViewModel>>, String> {
  SelectedBudgetMetadataByPlanFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetMetadataByPlanProvider',
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          SelectedBudgetMetadataByPlanProvider.$allTransitiveDependencies0,
          SelectedBudgetMetadataByPlanProvider.$allTransitiveDependencies1,
          SelectedBudgetMetadataByPlanProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  SelectedBudgetMetadataByPlanProvider call({required String id}) =>
      SelectedBudgetMetadataByPlanProvider._(argument: id, from: this);

  @override
  String toString() => r'selectedBudgetMetadataByPlanProvider';
}
