import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide BudgetPlanAllocationViewModelExtension;
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String budgetId = 'budget-id';

  tearDown(mockUseCases.reset);

  group('SelectedBudgetProvider', () {
    Future<BudgetState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetProvider(budgetId).future);
    }

    test('should show selected budget by id', () async {
      final List<BudgetPlanEntity> expectedPlans = <BudgetPlanEntity>[
        BudgetPlansMockImpl.generatePlan(),
      ];
      final BudgetEntity expectedBudget = BudgetsMockImpl.generateBudget();
      final List<BudgetAllocationEntity> expectedBudgetAllocations = <BudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateAllocation(
          budget: expectedBudget,
          plan: expectedPlans.random(),
        ),
      ];
      when(() => mockUseCases.fetchBudgetUseCase.call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')))
          .thenAnswer((_) => Stream<BudgetEntity>.value(expectedBudget));
      when(
        () => mockUseCases.fetchBudgetAllocationsByBudgetUseCase
            .call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')),
      ).thenAnswer((_) => Stream<BudgetAllocationEntityList>.value(expectedBudgetAllocations));

      final List<BudgetPlanViewModel> expectedPlanViewModels = expectedPlans
          .map(
            (BudgetPlanEntity plan) => BudgetPlanViewModel.fromEntity(
              plan,
              expectedBudgetAllocations
                  .firstWhereOrNull((_) => _.plan.id == plan.id && _.budget.id == expectedBudget.id)
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
            allocation: expectedPlanViewModels.map((_) => _.allocation?.amount).whereNotNull().sum(),
            categories: expectedPlans
                .uniqueBy((_) => _.category.id)
                .map((_) => _.category)
                .map(
                  (BudgetCategoryEntity category) => category.toViewModel(
                    expectedBudgetAllocations
                        .where((_) => _.plan.category.id == category.id && _.budget.id == expectedBudget.id)
                        .map((_) => _.amount.asMoney)
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
