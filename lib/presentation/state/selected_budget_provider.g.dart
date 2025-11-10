// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_budget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedBudget)
const selectedBudgetProvider = SelectedBudgetFamily._();

final class SelectedBudgetProvider
    extends $FunctionalProvider<AsyncValue<BudgetState>, BudgetState, Stream<BudgetState>>
    with $FutureModifier<BudgetState>, $StreamProvider<BudgetState> {
  const SelectedBudgetProvider._({
    required SelectedBudgetFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedBudgetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = registryProvider;
  static const $allTransitiveDependencies1 = userProvider;
  static const $allTransitiveDependencies2 = UserProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$selectedBudgetHash();

  @override
  String toString() {
    return r'selectedBudgetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<BudgetState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BudgetState> create(Ref ref) {
    final argument = this.argument as String;
    return selectedBudget(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedBudgetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedBudgetHash() => r'65bad1a17951f8df9675a28596835fd90f6493c9';

final class SelectedBudgetFamily extends $Family with $FunctionalFamilyOverride<Stream<BudgetState>, String> {
  const SelectedBudgetFamily._()
    : super(
        retry: null,
        name: r'selectedBudgetProvider',
        dependencies: const <ProviderOrFamily>[registryProvider, userProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          SelectedBudgetProvider.$allTransitiveDependencies0,
          SelectedBudgetProvider.$allTransitiveDependencies1,
          SelectedBudgetProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  SelectedBudgetProvider call(String id) => SelectedBudgetProvider._(argument: id, from: this);

  @override
  String toString() => r'selectedBudgetProvider';
}
