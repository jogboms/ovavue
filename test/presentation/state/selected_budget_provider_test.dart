import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide NormalizedBudgetAllocationViewModelExtension;
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
      final List<NormalizedBudgetPlanEntity> expectedPlans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(),
      ];
      final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget();
      final List<NormalizedBudgetAllocationEntity> expectedBudgetAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(
          budget: expectedBudget,
          plan: expectedPlans.random(),
        ),
      ];
      when(() => mockUseCases.fetchBudgetUseCase.call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')))
          .thenAnswer((_) => Stream<NormalizedBudgetEntity>.value(expectedBudget));
      when(
        () => mockUseCases.fetchBudgetAllocationsByBudgetUseCase
            .call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetAllocationEntityList>.value(expectedBudgetAllocations));

      final List<SelectedBudgetPlanViewModel> expectedPlanViewModels = expectedPlans
          .map(
            (NormalizedBudgetPlanEntity plan) => plan.toViewModel(
              allocation: expectedBudgetAllocations
                  .firstWhereOrNull((_) => _.plan.id == plan.id && _.budget.id == expectedBudget.id)
                  ?.toViewModel(),
              category: plan.category.toViewModel(expectedBudgetAllocations.first.amount.asMoney),
            ),
          )
          .toList();

      expect(
        createProviderStream(),
        completion(
          BudgetState(
            budget: expectedBudget.toViewModel(expectedPlanViewModels),
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
