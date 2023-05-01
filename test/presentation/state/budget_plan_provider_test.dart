import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../mocks.dart';
import '../../utils.dart';

Future<void> main() async {
  group('BudgetPlanProvider', () {
    final MockAsyncCallback<UserEntity> mockFetchUser = MockAsyncCallback<UserEntity>();
    final UserEntity dummyUser = UsersMockImpl.user;

    setUpAll(() {
      registerFallbackValue(FakeCreateBudgetPlanData());
      registerFallbackValue(FakeUpdateBudgetPlanData());
      registerFallbackValue(FakeCreateBudgetAllocationData());
      registerFallbackValue(FakeUpdateBudgetAllocationData());
    });

    tearDown(() {
      reset(mockFetchUser);
      mockUseCases.reset();
    });

    BudgetPlanProvider createProvider() => BudgetPlanProvider(
          fetchUser: mockFetchUser,
          createBudgetPlanUseCase: mockUseCases.createBudgetPlanUseCase,
          updateBudgetPlanUseCase: mockUseCases.updateBudgetPlanUseCase,
          deleteBudgetPlanUseCase: mockUseCases.deleteBudgetPlanUseCase,
          createBudgetAllocationUseCase: mockUseCases.createBudgetAllocationUseCase,
          updateBudgetAllocationUseCase: mockUseCases.updateBudgetAllocationUseCase,
          deleteBudgetAllocationUseCase: mockUseCases.deleteBudgetAllocationUseCase,
        );

    test('should create new instance when read', () {
      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(budgetPlanProvider), isA<BudgetPlanProvider>());
    });

    test('should create new budget plan for user from userProvider', () async {
      when(() => mockUseCases.createBudgetPlanUseCase.call(plan: any(named: 'plan'), userId: any(named: 'userId')))
          .thenAnswer((_) async => '1');

      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      addTearDown(container.dispose);

      final BudgetPlanProvider provider = container.read(budgetPlanProvider);

      final String id = await provider.create(
        const CreateBudgetPlanData(
          title: 'title',
          description: 'description',
          category: (id: 'id', path: 'path'),
        ),
      );

      expect(id, '1');
    });

    group('Create', () {
      test('should create new budget plan for user', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(() => mockUseCases.createBudgetPlanUseCase.call(plan: any(named: 'plan'), userId: any(named: 'userId')))
            .thenAnswer((_) async => '1');

        const CreateBudgetPlanData createBudgetPlanData = CreateBudgetPlanData(
          title: 'title',
          description: 'description',
          category: (id: 'id', path: 'path'),
        );
        final String budgetPlanId = await createProvider().create(createBudgetPlanData);

        expect(budgetPlanId, '1');
        verify(mockFetchUser.call).called(1);

        verify(() => mockUseCases.createBudgetPlanUseCase.call(userId: dummyUser.id, plan: createBudgetPlanData))
            .called(1);
      });
    });

    group('Update', () {
      test('should update existing budget plan', () async {
        when(() => mockUseCases.updateBudgetPlanUseCase.call(any())).thenAnswer((_) async => true);

        const UpdateBudgetPlanData updateBudgetPlanData = UpdateBudgetPlanData(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          categoryId: '1',
          categoryPath: 'path',
        );
        await createProvider().update(updateBudgetPlanData);

        verify(() => mockUseCases.updateBudgetPlanUseCase.call(updateBudgetPlanData)).called(1);
      });
    });

    group('Update category', () {
      test('should update existing budget plan\'s category', () async {
        when(() => mockUseCases.updateBudgetPlanUseCase.call(any())).thenAnswer((_) async => true);

        final BudgetCategoryViewModel expectedCategory = BudgetCategoryViewModel(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          icon: BudgetCategoryIcon.values.first,
          colorScheme: BudgetCategoryColorScheme.values.first,
          createdAt: DateTime(0),
          updatedAt: DateTime(0),
        );
        final BudgetPlanViewModel expectedPlan = BudgetPlanViewModel(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          allocation: null,
          category: expectedCategory,
          createdAt: DateTime(0),
          updatedAt: DateTime(0),
        );

        const UpdateBudgetPlanData updateBudgetPlanData = UpdateBudgetPlanData(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          categoryId: '1',
          categoryPath: 'path',
        );
        await createProvider().updateCategory(plan: expectedPlan, category: expectedCategory);

        final UpdateBudgetPlanData updateData =
            verify(() => mockUseCases.updateBudgetPlanUseCase.call(captureAny())).capturedType();
        expect(updateData.id, updateBudgetPlanData.id);
        expect(updateData.path, updateBudgetPlanData.path);
      });
    });

    group('Delete', () {
      test('should delete existing budget plan', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(() => mockUseCases.deleteBudgetPlanUseCase.call(userId: dummyUser.id, id: '1', path: 'path'))
            .thenAnswer((_) async => true);

        await createProvider().delete(id: '1', path: 'path');

        verify(() => mockUseCases.deleteBudgetPlanUseCase.call(userId: dummyUser.id, id: '1', path: 'path')).called(1);
      });
    });

    group('Delete allocation', () {
      test('should delete existing budget plan', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(() => mockUseCases.deleteBudgetAllocationUseCase.call(id: any(named: 'id'), path: any(named: 'path')))
            .thenAnswer((_) async => true);

        await createProvider().deleteAllocation(id: '1', path: 'path');

        verify(() => mockUseCases.deleteBudgetAllocationUseCase.call(id: '1', path: 'path')).called(1);
      });
    });

    group('Create allocation', () {
      test('should create new budget allocation for plan', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(
          () => mockUseCases.createBudgetAllocationUseCase.call(
            allocation: any(named: 'allocation'),
            userId: any(named: 'userId'),
          ),
        ).thenAnswer((_) async => '1');

        const CreateBudgetAllocationData createBudgetAllocationData = CreateBudgetAllocationData(
          amount: 1,
          budget: (id: 'id', path: 'path'),
          plan: (id: 'id', path: 'path'),
        );
        final String budgetPlanId = await createProvider().createAllocation(createBudgetAllocationData);

        expect(budgetPlanId, '1');
        verify(mockFetchUser.call).called(1);

        verify(
          () => mockUseCases.createBudgetAllocationUseCase.call(
            userId: dummyUser.id,
            allocation: createBudgetAllocationData,
          ),
        ).called(1);
      });
    });

    group('Update allocation', () {
      test('should update existing budget allocation for plan', () async {
        when(() => mockUseCases.updateBudgetAllocationUseCase.call(any())).thenAnswer((_) async => true);

        const UpdateBudgetAllocationData updateBudgetAllocationData = UpdateBudgetAllocationData(
          id: '1',
          path: 'path',
          amount: 1,
        );
        await createProvider().updateAllocation(updateBudgetAllocationData);

        verify(() => mockUseCases.updateBudgetAllocationUseCase.call(updateBudgetAllocationData)).called(1);
      });
    });
  });
}
