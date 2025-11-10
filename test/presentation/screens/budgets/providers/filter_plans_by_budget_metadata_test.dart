import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  const budgetId = 'budget-id';
  const metadataId = 'metadata-id';

  final expectedBudget = BudgetsMockImpl.generateBudget(id: budgetId);
  final expectedMetadata = BudgetMetadataMockImpl.generateMetadataValue(id: metadataId);
  final expectedState = BudgetPlansByMetadataState(
    budget: BudgetViewModel.fromEntity(expectedBudget),
    plans: <BudgetPlanViewModel>[],
    allocation: Money.zero,
    key: BudgetMetadataKeyViewModel.fromEntity(expectedMetadata.key),
    metadata: BudgetMetadataValueViewModel.fromEntity(expectedMetadata),
  );

  group('FilterPlansByBudgetMetadataProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = createProviderContainer(
        overrides: <Override>[
          selectedBudgetPlansByMetadataProvider(id: metadataId, budgetId: budgetId).overrideWith(
            (_) => Stream<BudgetPlansByMetadataState>.value(expectedState),
          ),
        ],
      );
      addTearDown(container.dispose);
    });

    tearDown(mockUseCases.reset);

    test('should show state with plans for selected metadata', () async {
      container.read(filterMetadataIdProvider.notifier).setState(metadataId);

      expect(
        container.read(filterPlansByBudgetMetadataProvider(budgetId: budgetId).future),
        completion(expectedState),
      );
    });

    test('should return empty state when no valid metadata', () async {
      container.read(filterMetadataIdProvider.notifier).setState(null);

      expect(
        container.read(filterPlansByBudgetMetadataProvider(budgetId: budgetId).future),
        completion(BaseBudgetPlansByMetadataState.empty),
      );
    });
  });
}
