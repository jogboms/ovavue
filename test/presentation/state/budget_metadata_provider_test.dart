import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('BudgetMetadataProvider', () {
    final dummyUser = UsersMockImpl.user;
    late ProviderContainer container;

    setUpAll(() {
      registerFallbackValue((id: '1', path: 'path'));
      registerFallbackValue(
        const CreateBudgetMetadataData(
          title: 'title',
          description: 'description',
          operations: <BudgetMetadataValueOperation>{
            BudgetMetadataValueCreationOperation(title: 'title', value: 'value'),
          },
        ),
      );
      registerFallbackValue(
        const UpdateBudgetMetadataData(
          id: 'id',
          path: 'path',
          title: 'title',
          description: 'description',
          operations: <BudgetMetadataValueOperation>{
            BudgetMetadataValueCreationOperation(title: 'title', value: 'value'),
          },
        ),
      );
    });

    setUp(() {
      container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
    });

    tearDown(() {
      container.dispose();
      mockUseCases.reset();
    });

    test('should initialize with empty state', () {
      when(
        () => mockUseCases.fetchBudgetMetadataUseCase.call(any()),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value([]));

      expect(container.readAsync(budgetMetadataProvider.future), completes);
    });

    test('should emit fetched budget metadata', () {
      final expectedBudgetMetadata = BudgetMetadataValueEntityList.filled(
        3,
        BudgetMetadataMockImpl.generateMetadataValue(),
      );
      when(
        () => mockUseCases.fetchBudgetMetadataUseCase.call(any()),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value(expectedBudgetMetadata));

      expect(
        container.readAsync(budgetMetadataProvider.future),
        completion(
          expectedBudgetMetadata
              .groupListsBy((BudgetMetadataValueEntity e) => e.key)
              .entries
              .map((MapEntry<BudgetMetadataKeyEntity, List<BudgetMetadataValueEntity>> e) => e.toEntity())
              .toList(growable: false),
        ),
      );
    });

    test('should create new budget metadata', () {
      when(
        () => mockUseCases.createBudgetMetadataUseCase.call(
          metadata: any(named: 'metadata'),
          userId: dummyUser.id,
        ),
      ).thenAnswer((_) async => '1');

      expect(
        container
            .read(budgetMetadataProvider.notifier)
            .createMetadata(
              title: 'title',
              description: 'description',
              operations: const <BudgetMetadataValueOperation>{
                BudgetMetadataValueCreationOperation(title: 'title', value: 'value'),
              },
            ),
        completion('1'),
      );
    });

    test('should update new budget metadata', () {
      when(
        () => mockUseCases.updateBudgetMetadataUseCase.call(
          metadata: any(named: 'metadata'),
          userId: dummyUser.id,
        ),
      ).thenAnswer((_) async => true);

      expect(
        container
            .read(budgetMetadataProvider.notifier)
            .updateMetadata(
              id: '1',
              path: 'path',
              title: 'title',
              description: 'description',
              operations: const <BudgetMetadataValueOperation>{
                BudgetMetadataValueCreationOperation(title: 'title', value: 'value'),
              },
            ),
        completion(true),
      );
    });

    test('should add budget metadata to budget plan', () {
      when(
        () => mockUseCases.addMetadataToPlanUseCase.call(
          plan: any(named: 'plan'),
          metadata: any(named: 'metadata'),
          userId: dummyUser.id,
        ),
      ).thenAnswer((_) async => true);

      expect(
        container
            .read(budgetMetadataProvider.notifier)
            .addMetadataToPlan(
              plan: (id: '1', path: 'path'),
              metadata: (id: '1', path: 'path'),
            ),
        completion(true),
      );
    });

    test('should remove budget metadata from budget plan', () {
      when(
        () => mockUseCases.removeMetadataFromPlanUseCase.call(
          plan: any(named: 'plan'),
          metadata: any(named: 'metadata'),
          userId: dummyUser.id,
        ),
      ).thenAnswer((_) async => true);

      expect(
        container
            .read(budgetMetadataProvider.notifier)
            .removeMetadataFromPlan(
              plan: (id: '1', path: 'path'),
              metadata: (id: '1', path: 'path'),
            ),
        completion(true),
      );
    });
  });
}
