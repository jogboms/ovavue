// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_metadata_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BudgetMetadata)
final budgetMetadataProvider = BudgetMetadataProvider._();

final class BudgetMetadataProvider extends $StreamNotifierProvider<BudgetMetadata, List<BudgetMetadataViewModel>> {
  BudgetMetadataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetMetadataProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          BudgetMetadataProvider.$allTransitiveDependencies0,
          BudgetMetadataProvider.$allTransitiveDependencies1,
          BudgetMetadataProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = registryProvider;
  static final $allTransitiveDependencies1 = userProvider;
  static final $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$budgetMetadataHash();

  @$internal
  @override
  BudgetMetadata create() => BudgetMetadata();
}

String _$budgetMetadataHash() => r'f91c6ae6c6927c2ab687019e2e0ad5ec50ae747a';

abstract class _$BudgetMetadata extends $StreamNotifier<List<BudgetMetadataViewModel>> {
  Stream<List<BudgetMetadataViewModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<BudgetMetadataViewModel>>, List<BudgetMetadataViewModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BudgetMetadataViewModel>>, List<BudgetMetadataViewModel>>,
              AsyncValue<List<BudgetMetadataViewModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
