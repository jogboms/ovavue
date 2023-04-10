import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('BudgetPlansProvider', () {
    final UserEntity dummyUser = UsersMockImpl.user;

    tearDown(mockUseCases.reset);

    Future<List<BudgetPlanViewModel>> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);
      return container.read(budgetPlansProvider.future);
    }

    test('should initialize with empty state', () {
      when(() => mockUseCases.fetchBudgetPlansUseCase.call(any()))
          .thenAnswer((_) => Stream<List<NormalizedBudgetPlanEntity>>.value(<NormalizedBudgetPlanEntity>[]));

      expect(createProviderStream(), completes);
    });

    test('should emit fetched tags', () {
      final List<NormalizedBudgetPlanEntity> expectedBudgetPlans =
          List<NormalizedBudgetPlanEntity>.filled(3, BudgetPlansMockImpl.generateNormalizedPlan());
      when(() => mockUseCases.fetchBudgetPlansUseCase.call(any()))
          .thenAnswer((_) => Stream<List<NormalizedBudgetPlanEntity>>.value(expectedBudgetPlans));

      expect(
        createProviderStream(),
        completion(expectedBudgetPlans.map(BudgetPlanViewModel.fromEntity).toList()),
      );
    });
  });
}
