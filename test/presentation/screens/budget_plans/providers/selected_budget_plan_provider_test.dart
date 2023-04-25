import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide BudgetAllocationViewModelExtension;
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String planId = 'plan-id';
  const String budgetId = 'budget-id';

  final NormalizedBudgetPlanEntity expectedPlan = BudgetPlansMockImpl.generateNormalizedPlan(id: planId);
  final List<NormalizedBudgetPlanEntity> expectedPlans = <NormalizedBudgetPlanEntity>[expectedPlan];
  final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget(id: budgetId);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetPlanProvider', () {
    Future<BudgetPlanState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          budgetsProvider.overrideWith(
            (_) => Stream<List<BudgetViewModel>>.value(
              <BudgetViewModel>[BudgetViewModel.fromEntity(expectedBudget, expectedPlans)],
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
      final List<NormalizedBudgetAllocationEntity> expectedBudgetAllocations =
          List<NormalizedBudgetAllocationEntity>.generate(
        3,
        (int index) => BudgetAllocationsMockImpl.generateNormalizedAllocation(
          budget: index == 0 ? expectedBudget : BudgetsMockImpl.generateNormalizedBudget(),
          plan: expectedPlans.first,
        ),
      );

      when(
        () => mockUseCases.fetchBudgetAllocationsByPlanUseCase
            .call(userId: any(named: 'userId'), planId: any(named: 'planId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetAllocationEntityList>.value(expectedBudgetAllocations));

      expect(
        createProviderStream(),
        completion(
          BudgetPlanState(
            allocation: expectedBudgetAllocations.firstWhere((_) => _.plan.id == expectedPlan.id).toViewModel(),
            plan: BudgetPlanViewModel.fromEntity(expectedPlan),
            budget: BudgetViewModel.fromEntity(expectedBudget, expectedPlans),
            previousAllocations: expectedBudgetAllocations
                .map((_) => _.toViewModel())
                .skip(1)
                .sorted(
                  (BudgetPlanAllocationViewModel a, BudgetPlanAllocationViewModel b) =>
                      b.budget.startedAt.compareTo(a.budget.startedAt),
                )
                .toList(),
          ),
        ),
      );
    });
  });
}
