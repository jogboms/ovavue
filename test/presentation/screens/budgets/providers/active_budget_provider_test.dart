import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;

  tearDown(mockUseCases.reset);

  group('ActiveBudgetProvider', () {
    Future<BaseBudgetState> createProviderStream(BudgetEntity? budget) {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          activeBudgetIdProvider.overrideWith((_) => Stream<String?>.value(budget?.id)),
          if (budget != null)
            selectedBudgetProvider(budget.id).overrideWith(
              (_) => Stream<BudgetState>.value(
                BudgetState(
                  budget: budget.toViewModel(<SelectedBudgetPlanViewModel>[]),
                  allocation: Money.zero,
                  categories: <SelectedBudgetCategoryViewModel>[],
                ),
              ),
            )
        ],
      );

      addTearDown(container.dispose);
      return container.read(activeBudgetProvider.future);
    }

    test('should show active budget', () async {
      final BudgetEntity expectedBudget = BudgetsMockImpl.generateBudget();

      expect(
        createProviderStream(expectedBudget),
        completion(
          BudgetState(
            budget: expectedBudget.toViewModel(<SelectedBudgetPlanViewModel>[]),
            allocation: Money.zero,
            categories: <SelectedBudgetCategoryViewModel>[],
          ),
        ),
      );
    });

    test('should return empty budget state when no active budget', () async {
      expect(
        createProviderStream(null),
        completion(BaseBudgetState.empty),
      );
    });
  });
}
