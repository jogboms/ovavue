import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;

  final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget();

  tearDown(mockUseCases.reset);

  group('ActiveBudgetProvider', () {
    Future<BudgetState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          activeBudgetIdProvider.overrideWith((_) => Stream<String>.value(expectedBudget.id)),
          selectedBudgetProvider(expectedBudget.id).overrideWith(
            (_) => Stream<BudgetState>.value(
              BudgetState(
                budget: expectedBudget.toViewModel(<SelectedBudgetPlanViewModel>[]),
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
      expect(
        createProviderStream(),
        completion(
          BudgetState(
            budget: expectedBudget.toViewModel(<SelectedBudgetPlanViewModel>[]),
            allocation: Money.zero,
            categories: <SelectedBudgetCategoryViewModel>[],
          ),
        ),
      );
    });
  });
}
