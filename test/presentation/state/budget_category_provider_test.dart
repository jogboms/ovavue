import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../mocks.dart';
import '../../utils.dart';

Future<void> main() async {
  group('BudgetCategoryProvider', () {
    final MockAsyncCallback<UserEntity> mockFetchUser = MockAsyncCallback<UserEntity>();
    final UserEntity dummyUser = UsersMockImpl.user;

    setUpAll(() {
      registerFallbackValue((id: '1', path: 'path'));
      registerFallbackValue(FakeCreateBudgetCategoryData());
      registerFallbackValue(FakeUpdateBudgetCategoryData());
    });

    tearDown(() {
      reset(mockFetchUser);
      mockUseCases.reset();
    });

    BudgetCategoryProvider createProvider() => BudgetCategoryProvider(
          fetchUser: mockFetchUser,
          createBudgetCategoryUseCase: mockUseCases.createBudgetCategoryUseCase,
          updateBudgetCategoryUseCase: mockUseCases.updateBudgetCategoryUseCase,
          deleteBudgetCategoryUseCase: mockUseCases.deleteBudgetCategoryUseCase,
        );

    test('should create new instance when read', () {
      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(budgetCategoryProvider), isA<BudgetCategoryProvider>());
    });

    test('should create new budget plan for user from userProvider', () async {
      when(
        () => mockUseCases.createBudgetCategoryUseCase.call(
          category: any(named: 'category'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => '1');

      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);

      final BudgetCategoryProvider provider = container.read(budgetCategoryProvider);

      final String id = await provider.create(
        const CreateBudgetCategoryData(
          title: 'title',
          description: 'description',
          iconIndex: 1,
          colorSchemeIndex: 1,
        ),
      );

      expect(id, '1');
    });

    group('Create', () {
      test('should create new budget category for user', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(
          () => mockUseCases.createBudgetCategoryUseCase.call(
            category: any(named: 'category'),
            userId: any(named: 'userId'),
          ),
        ).thenAnswer((_) async => '1');

        const CreateBudgetCategoryData createBudgetCategoryData = CreateBudgetCategoryData(
          title: 'title',
          description: 'description',
          iconIndex: 1,
          colorSchemeIndex: 1,
        );
        final String budgetCategoryId = await createProvider().create(createBudgetCategoryData);

        expect(budgetCategoryId, '1');
        verify(mockFetchUser.call).called(1);

        verify(
          () => mockUseCases.createBudgetCategoryUseCase.call(
            userId: dummyUser.id,
            category: createBudgetCategoryData,
          ),
        ).called(1);
      });
    });

    group('Update', () {
      test('should update existing budget category', () async {
        when(() => mockUseCases.updateBudgetCategoryUseCase.call(any())).thenAnswer((_) async => true);

        const UpdateBudgetCategoryData updateBudgetCategoryData = UpdateBudgetCategoryData(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          iconIndex: 1,
          colorSchemeIndex: 1,
        );
        await createProvider().update(updateBudgetCategoryData);

        verify(() => mockUseCases.updateBudgetCategoryUseCase.call(updateBudgetCategoryData)).called(1);
      });
    });

    group('Delete', () {
      test('should delete existing budget category', () async {
        when(() => mockUseCases.deleteBudgetCategoryUseCase.call(any())).thenAnswer((_) async => true);

        await createProvider().delete((id: '1', path: 'path'));

        verify(() => mockUseCases.deleteBudgetCategoryUseCase.call((id: '1', path: 'path'))).called(1);
      });
    });
  });
}
