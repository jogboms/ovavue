import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('BudgetsProvider', () {
    final UserEntity dummyUser = UsersMockImpl.user;

    tearDown(mockUseCases.reset);

    Future<List<BudgetViewModel>> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);
      return container.read(budgetsProvider.future);
    }

    test('should initialize with empty state', () {
      when(() => mockUseCases.fetchBudgetsUseCase.call(any()))
          .thenAnswer((_) => Stream<List<NormalizedBudgetEntity>>.value(<NormalizedBudgetEntity>[]));
      when(() => mockUseCases.fetchBudgetAllocationsUseCase.call(any())).thenAnswer(
        (_) => Stream<BudgetIdToPlansMap>.value(BudgetIdToPlansMap.identity()),
      );

      expect(createProviderStream(), completes);
    });

    test('should emit fetched budgets', () {
      final List<NormalizedBudgetEntity> expectedBudgets =
          List<NormalizedBudgetEntity>.filled(3, BudgetsMockImpl.generateNormalizedBudget());
      final List<NormalizedBudgetPlanEntity> expectedPlans =
          NormalizedBudgetPlanEntityList.generate(3, (_) => BudgetPlansMockImpl.generateNormalizedPlan());
      when(() => mockUseCases.fetchBudgetsUseCase.call(any()))
          .thenAnswer((_) => Stream<List<NormalizedBudgetEntity>>.value(expectedBudgets));
      when(() => mockUseCases.fetchBudgetAllocationsUseCase.call(any())).thenAnswer(
        (_) => Stream<BudgetIdToPlansMap>.value(
          expectedBudgets.foldToMap((_) => _.id).map(
                (String id, NormalizedBudgetEntity budget) => MapEntry<String, Set<NormalizedBudgetPlanEntity>>(
                  id,
                  expectedPlans.toSet(),
                ),
              ),
        ),
      );

      expect(
        createProviderStream(),
        completion(
          expectedBudgets
              .map((NormalizedBudgetEntity budget) => BudgetViewModel.fromEntity(budget, expectedPlans))
              .toList(),
        ),
      );
    });
  });
}
