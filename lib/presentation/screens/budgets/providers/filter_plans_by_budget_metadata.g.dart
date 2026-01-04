// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_plans_by_budget_metadata.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filterPlansByBudgetMetadata)
final filterPlansByBudgetMetadataProvider = FilterPlansByBudgetMetadataFamily._();

final class FilterPlansByBudgetMetadataProvider
    extends
        $FunctionalProvider<
          AsyncValue<BaseBudgetPlansByMetadataState>,
          BaseBudgetPlansByMetadataState,
          FutureOr<BaseBudgetPlansByMetadataState>
        >
    with $FutureModifier<BaseBudgetPlansByMetadataState>, $FutureProvider<BaseBudgetPlansByMetadataState> {
  FilterPlansByBudgetMetadataProvider._({
    required FilterPlansByBudgetMetadataFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filterPlansByBudgetMetadataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = selectedBudgetPlansByMetadataProvider;
  static final $allTransitiveDependencies1 = SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 = SelectedBudgetPlansByMetadataProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$filterPlansByBudgetMetadataHash();

  @override
  String toString() {
    return r'filterPlansByBudgetMetadataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BaseBudgetPlansByMetadataState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BaseBudgetPlansByMetadataState> create(Ref ref) {
    final argument = this.argument as String;
    return filterPlansByBudgetMetadata(ref, budgetId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FilterPlansByBudgetMetadataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filterPlansByBudgetMetadataHash() => r'2535a3941095b76ba97cb972b014aa82e439d011';

final class FilterPlansByBudgetMetadataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BaseBudgetPlansByMetadataState>, String> {
  FilterPlansByBudgetMetadataFamily._()
    : super(
        retry: null,
        name: r'filterPlansByBudgetMetadataProvider',
        dependencies: <ProviderOrFamily>[selectedBudgetPlansByMetadataProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies0,
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies1,
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies2,
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies3,
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies4,
          FilterPlansByBudgetMetadataProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  FilterPlansByBudgetMetadataProvider call({required String budgetId}) =>
      FilterPlansByBudgetMetadataProvider._(argument: budgetId, from: this);

  @override
  String toString() => r'filterPlansByBudgetMetadataProvider';
}

@ProviderFor(FilterMetadataId)
final filterMetadataIdProvider = FilterMetadataIdProvider._();

final class FilterMetadataIdProvider extends $NotifierProvider<FilterMetadataId, String?> {
  FilterMetadataIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterMetadataIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterMetadataIdHash();

  @$internal
  @override
  FilterMetadataId create() => FilterMetadataId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$filterMetadataIdHash() => r'f93b5771e62146e70b8aeef93845639cc50c1675';

abstract class _$FilterMetadataId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
