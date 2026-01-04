// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeBudget)
final activeBudgetProvider = ActiveBudgetProvider._();

final class ActiveBudgetProvider
    extends $FunctionalProvider<AsyncValue<BaseBudgetState>, BaseBudgetState, Stream<BaseBudgetState>>
    with $FutureModifier<BaseBudgetState>, $StreamProvider<BaseBudgetState> {
  ActiveBudgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeBudgetProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          activeBudgetIdProvider,
          selectedBudgetProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ActiveBudgetProvider.$allTransitiveDependencies0,
          ActiveBudgetProvider.$allTransitiveDependencies1,
          ActiveBudgetProvider.$allTransitiveDependencies2,
          ActiveBudgetProvider.$allTransitiveDependencies3,
          ActiveBudgetProvider.$allTransitiveDependencies4,
        },
      );

  static final $allTransitiveDependencies0 = activeBudgetIdProvider;
  static final $allTransitiveDependencies1 = ActiveBudgetIdProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = ActiveBudgetIdProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = ActiveBudgetIdProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = selectedBudgetProvider;

  @override
  String debugGetCreateSourceHash() => _$activeBudgetHash();

  @$internal
  @override
  $StreamProviderElement<BaseBudgetState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BaseBudgetState> create(Ref ref) {
    return activeBudget(ref);
  }
}

String _$activeBudgetHash() => r'a7c8dfd9efdd369bdbca0ab16a2310e32c340870';
