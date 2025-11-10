import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

Future<void> main() async {
  group('BudgetsProvider', () {
    final dummyUser = UsersMockImpl.user;

    tearDown(mockUseCases.reset);

    Future<List<BudgetViewModel>> createProviderStream() {
      final container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);
      return container.read(budgetsProvider.future);
    }

    test('should initialize with empty state', () {
      when(
        () => mockUseCases.fetchBudgetsUseCase.call(any()),
      ).thenAnswer((_) => Stream<List<BudgetEntity>>.value([]));

      expect(createProviderStream(), completes);
    });

    test('should emit fetched budgets', () {
      final expectedBudgets = List<BudgetEntity>.filled(3, BudgetsMockImpl.generateBudget());
      when(
        () => mockUseCases.fetchBudgetsUseCase.call(any()),
      ).thenAnswer((_) => Stream<List<BudgetEntity>>.value(expectedBudgets));

      expect(
        createProviderStream(),
        completion(
          expectedBudgets.map(BudgetViewModel.fromEntity).toList(),
        ),
      );
    });
  });
}
