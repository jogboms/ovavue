import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('SelectedBudgetPlansByMetadataProvider', () {
    final dummyUser = UsersMockImpl.user;
    const budgetId = 'budget-id';
    const planId = 'plan-id';
    const metadataId = 'metadata-id';

    final expectedBudget = BudgetsMockImpl.generateBudget(id: budgetId);
    final expectedPlan = BudgetPlansMockImpl.generatePlan(id: planId);
    final expectedMetadata = BudgetMetadataMockImpl.generateMetadataValue(id: metadataId);

    tearDown(mockUseCases.reset);

    Future<BudgetPlansByMetadataState> createProviderStream() {
      final container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          selectedBudgetProvider(expectedBudget.id).overrideWith(
            (_) => Stream<BudgetState>.value(
              BudgetState(
                budget: BudgetViewModel.fromEntity(expectedBudget),
                plans: <BudgetPlanEntity>[
                  expectedPlan,
                  BudgetPlansMockImpl.generatePlan(),
                ].map(BudgetPlanViewModel.fromEntity).toList(),
                allocation: Money.zero,
                categories: <SelectedBudgetCategoryViewModel>[],
              ),
            ),
          ),
          budgetMetadataProvider.overrideWith(
            () => MockBudgetMetadata(
              <BudgetMetadataValueEntity>[
                    expectedMetadata,
                    BudgetMetadataMockImpl.generateMetadataValue(),
                  ]
                  .groupListsBy((BudgetMetadataValueEntity e) => e.key)
                  .entries
                  .map((MapEntry<BudgetMetadataKeyEntity, List<BudgetMetadataValueEntity>> e) => e.toEntity())
                  .toList(growable: false),
            ),
          ),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetPlansByMetadataProvider(id: metadataId, budgetId: budgetId).future);
    }

    test('should initialize with empty state', () {
      when(
        () => mockUseCases.fetchBudgetPlansByMetadataUseCase.call(userId: dummyUser.id, metadataId: metadataId),
      ).thenAnswer((_) => Stream<BudgetPlanEntityList>.value(<BudgetPlanEntity>[]));

      expect(createProviderStream(), completes);
    });

    test('should emit fetched budget plans by metadata', () {
      when(
        () => mockUseCases.fetchBudgetPlansByMetadataUseCase.call(userId: dummyUser.id, metadataId: metadataId),
      ).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.value(<BudgetPlanEntity>[
          expectedPlan,
          BudgetPlansMockImpl.generatePlan(),
        ]),
      );

      expect(
        createProviderStream(),
        completion(
          BudgetPlansByMetadataState(
            budget: BudgetViewModel.fromEntity(expectedBudget),
            allocation: Money.zero,
            key: BudgetMetadataKeyViewModel.fromEntity(expectedMetadata.key),
            metadata: BudgetMetadataValueViewModel.fromEntity(expectedMetadata),
            plans: <BudgetPlanEntity>[expectedPlan].map(BudgetPlanViewModel.fromEntity).toList(),
          ),
        ),
      );
    });
  });
}

class MockBudgetMetadata extends AutoDisposeStreamNotifier<List<BudgetMetadataViewModel>>
    with Mock
    implements BudgetMetadata {
  MockBudgetMetadata([this._initialValue = const <BudgetMetadataViewModel>[]]);

  final List<BudgetMetadataViewModel> _initialValue;

  @override
  Stream<List<BudgetMetadataViewModel>> build() => Stream<List<BudgetMetadataViewModel>>.value(_initialValue);
}
