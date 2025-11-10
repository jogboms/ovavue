import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final dummyUser = UsersMockImpl.user;

  tearDown(mockUseCases.reset);

  group('ActiveBudgetProvider', () {
    Future<BaseBudgetState> createProviderStream(BudgetEntity? budget) {
      final container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          activeBudgetIdProvider.overrideWith((_) => Stream<String?>.value(budget?.id)),
          if (budget != null)
            selectedBudgetProvider(budget.id).overrideWith(
              (_) => Stream<BudgetState>.value(
                BudgetState(
                  budget: BudgetViewModel.fromEntity(budget),
                  plans: <BudgetPlanViewModel>[],
                  allocation: Money.zero,
                  categories: <SelectedBudgetCategoryViewModel>[],
                ),
              ),
            ),
        ],
      );

      addTearDown(container.dispose);
      return container.read(activeBudgetProvider.future);
    }

    test('should show active budget', () async {
      final expectedBudget = BudgetsMockImpl.generateBudget();

      expect(
        createProviderStream(expectedBudget),
        completion(
          BudgetState(
            budget: BudgetViewModel.fromEntity(expectedBudget),
            plans: <BudgetPlanViewModel>[],
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
