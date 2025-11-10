import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('SelectedBudgetMetadataByPlanProvider', () {
    final dummyUser = UsersMockImpl.user;
    const planId = 'plan-id';

    tearDown(mockUseCases.reset);

    Future<List<BudgetMetadataValueViewModel>> createProviderStream() {
      final container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);
      return container.read(selectedBudgetMetadataByPlanProvider(id: planId).future);
    }

    test('should initialize with empty state', () {
      when(
        () => mockUseCases.fetchBudgetMetadataByPlanUseCase.call(userId: dummyUser.id, planId: planId),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value(<BudgetMetadataValueEntity>[]));

      expect(createProviderStream(), completes);
    });

    test('should emit fetched tags', () {
      final expectedBudgetMetadata = BudgetMetadataValueEntityList.filled(
        3,
        BudgetMetadataMockImpl.generateMetadataValue(),
      );
      when(
        () => mockUseCases.fetchBudgetMetadataByPlanUseCase.call(userId: dummyUser.id, planId: planId),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value(expectedBudgetMetadata));

      expect(
        createProviderStream(),
        completion(expectedBudgetMetadata.map(BudgetMetadataValueViewModel.fromEntity).toList()),
      );
    });
  });
}
