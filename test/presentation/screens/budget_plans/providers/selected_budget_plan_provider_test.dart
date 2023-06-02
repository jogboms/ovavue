import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String planId = 'plan-id';
  const String budgetId = 'budget-id';

  final BudgetPlanEntity expectedPlan = BudgetPlansMockImpl.generatePlan(id: planId);
  final List<BudgetPlanEntity> expectedPlans = <BudgetPlanEntity>[expectedPlan];
  final BudgetEntity expectedBudget = BudgetsMockImpl.generateBudget(id: budgetId);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetPlanProvider', () {
    Future<BudgetPlanState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          budgetsProvider.overrideWith(
            (_) => Stream<List<BudgetViewModel>>.value(
              <BudgetViewModel>[BudgetViewModel.fromEntity(expectedBudget)],
            ),
          ),
          budgetPlansProvider.overrideWith(
            (_) => Stream<List<BudgetPlanViewModel>>.value(
              <BudgetPlanViewModel>[BudgetPlanViewModel.fromEntity(expectedPlan)],
            ),
          ),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetPlanProvider(id: planId, budgetId: budgetId).future);
    }

    test('should show selected plan by id', () async {
      final List<BudgetAllocationEntity> expectedBudgetAllocations = List<BudgetAllocationEntity>.generate(
        3,
        (int index) => BudgetAllocationsMockImpl.generateAllocation(
          budget: index == 0 ? expectedBudget : BudgetsMockImpl.generateBudget(),
          plan: expectedPlans.first,
        ),
      );
      final List<BudgetMetadataValueEntity> expectedBudgetMetadata = BudgetMetadataValueEntityList.generate(
        3,
        (_) => BudgetMetadataMockImpl.generateMetadataValue(),
      );

      when(
        () => mockUseCases.fetchBudgetAllocationsByPlanUseCase
            .call(userId: any(named: 'userId'), planId: any(named: 'planId')),
      ).thenAnswer((_) => Stream<BudgetAllocationEntityList>.value(expectedBudgetAllocations));
      when(
        () => mockUseCases.fetchBudgetMetadataByPlanUseCase
            .call(userId: any(named: 'userId'), planId: any(named: 'planId')),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value(expectedBudgetMetadata));

      expect(
        createProviderStream(),
        completion(
          BudgetPlanState(
            allocation: expectedBudgetAllocations.firstWhere((_) => _.plan.id == expectedPlan.id).toViewModel(),
            plan: BudgetPlanViewModel.fromEntity(expectedPlan),
            budget: BudgetViewModel.fromEntity(expectedBudget),
            metadata: expectedBudgetMetadata.map(BudgetMetadataValueViewModel.fromEntity).toList(growable: false),
            previousAllocations: expectedBudgetAllocations
                .map((_) => _.toViewModelPair())
                .skip(1)
                .sorted(
                  (BudgetPlanAllocationViewModel a, BudgetPlanAllocationViewModel b) =>
                      b.$2.startedAt.compareTo(a.$2.startedAt),
                )
                .toList(),
          ),
        ),
      );
    });
  });
}
