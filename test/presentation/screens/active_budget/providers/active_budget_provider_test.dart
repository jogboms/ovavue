import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide NormalizedBudgetAllocationViewModelExtension;
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;

  tearDown(mockUseCases.reset);

  group('ActiveBudgetProvider', () {
    Future<ActiveBudgetState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );

      addTearDown(container.dispose);
      return container.read(activeBudgetProvider.future);
    }

    test('should show active budget', () async {
      final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget(
        plans: <NormalizedBudgetPlanEntity>[
          BudgetPlansMockImpl.generateNormalizedPlan(),
        ],
      );
      final List<NormalizedBudgetAllocationEntity> expectedBudgetAllocations = <NormalizedBudgetAllocationEntity>[
        BudgetAllocationsMockImpl.generateNormalizedAllocation(
          budget: expectedBudget,
          plan: expectedBudget.plans.random(),
        ),
      ];
      when(() => mockUseCases.fetchActiveBudgetUseCase.call(any()))
          .thenAnswer((_) => Stream<NormalizedBudgetEntity>.value(expectedBudget));
      when(
        () => mockUseCases.fetchBudgetAllocationsUseCase
            .call(userId: any(named: 'userId'), budgetId: any(named: 'budgetId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetAllocationEntityList>.value(expectedBudgetAllocations));

      final List<ActiveBudgetPlanViewModel> expectedPlans = expectedBudget.plans
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
          ActiveBudgetState(
            budget: expectedBudget.toViewModel(expectedPlans),
            allocation: expectedPlans.map((_) => _.allocation?.amount).whereNotNull().sum(),
            categories: expectedBudget.plans
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
