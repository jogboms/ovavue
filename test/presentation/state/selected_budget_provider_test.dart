import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

Future<void> main() async {
  final dummyUser = UsersMockImpl.user;
  const budgetId = 'budget-id';

  tearDown(mockUseCases.reset);

  group('SelectedBudgetProvider', () {
    Future<BudgetState> createProviderStream() {
      final container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetProvider(budgetId).future);
    }

    test('should show selected budget by id', () async {
      final expectedPlans = [
        BudgetPlansMockImpl.generatePlan(),
      ];
      final expectedBudget = BudgetsMockImpl.generateBudget();
      final expectedBudgetAllocations = [
        BudgetAllocationsMockImpl.generateAllocation(
          budget: expectedBudget,
          plan: expectedPlans.random(),
        ),
      ];
      when(
        () => mockUseCases.fetchBudgetUseCase.call(
          userId: any(named: 'userId'),
          budgetId: any(named: 'budgetId'),
        ),
      ).thenAnswer((_) => Stream.value(expectedBudget));
      when(
        () => mockUseCases.fetchBudgetAllocationsByBudgetUseCase.call(
          userId: any(named: 'userId'),
          budgetId: any(named: 'budgetId'),
        ),
      ).thenAnswer((_) => Stream.value(expectedBudgetAllocations));

      final expectedPlanViewModels = expectedPlans
          .map(
            (plan) => BudgetPlanViewModel.fromEntity(
              plan,
              expectedBudgetAllocations
                  .firstWhereOrNull((e) => e.plan.id == plan.id && e.budget.id == expectedBudget.id)
                  ?.toViewModel(),
            ),
          )
          .toList();

      expect(
        createProviderStream(),
        completion(
          BudgetState(
            budget: BudgetViewModel.fromEntity(expectedBudget),
            plans: expectedPlanViewModels,
            allocation: expectedPlanViewModels.map((e) => e.allocation?.amount).nonNulls.sum(),
            categories: expectedPlans
                .uniqueBy((e) => e.category.id)
                .map((e) => e.category)
                .map(
                  (category) => category.toViewModel(
                    expectedBudgetAllocations
                        .where((e) => e.plan.category.id == category.id && e.budget.id == expectedBudget.id)
                        .map((e) => e.amount.asMoney)
                        .sum(),
                  ),
                )
                .toList(),
          ),
        ),
      );
    });
  });
}
