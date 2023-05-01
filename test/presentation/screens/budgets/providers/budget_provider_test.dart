import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide BudgetPlanAllocationViewModelExtension;
import 'package:riverpod/riverpod.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

Future<void> main() async {
  group('BudgetProvider', () {
    final MockAsyncCallback<UserEntity> mockFetchUser = MockAsyncCallback<UserEntity>();
    final MockAsyncCallback<String?> mockFetchActiveBudgetPath = MockAsyncCallback<String>();
    final MockAsyncCallbackValueChanged<PlanToAllocationMap, String> mockFetchBudgetAllocations =
        MockAsyncCallbackValueChanged<PlanToAllocationMap, String>();

    final UserEntity dummyUser = UsersMockImpl.user;
    final BudgetEntity dummyBudget = BudgetsMockImpl.generateBudget();
    final BudgetPlanEntity dummyBudgetPlan = BudgetPlansMockImpl.generatePlan(id: '1');
    final BudgetCategoryEntity dummyBudgetCategory = BudgetCategoriesMockImpl.generateCategory(id: '1');
    final BudgetAllocationEntity dummyAllocation = BudgetAllocationsMockImpl.generateAllocation(
      id: '1',
      plan: dummyBudgetPlan,
      budget: dummyBudget,
    );
    final BudgetState dummyBudgetState = BudgetState(
      budget: BudgetViewModel.fromEntity(dummyBudget),
      plans: <BudgetPlanViewModel>[
        BudgetPlanViewModel.fromEntity(dummyBudgetPlan, dummyAllocation.toViewModel()),
      ],
      allocation: dummyAllocation.amount.asMoney,
      categories: <SelectedBudgetCategoryViewModel>[
        dummyBudgetCategory.toViewModel(dummyAllocation.amount.asMoney),
      ],
    );

    setUpAll(() {
      registerFallbackValue(FakeCreateBudgetData());
      registerFallbackValue(FakeUpdateBudgetData());
    });

    tearDown(() {
      reset(mockFetchUser);
      reset(mockFetchActiveBudgetPath);
      reset(mockFetchBudgetAllocations);
      mockUseCases.reset();
    });

    BudgetProvider createProvider() => BudgetProvider(
          fetchUser: mockFetchUser,
          fetchActiveBudgetPath: mockFetchActiveBudgetPath,
          fetchBudgetAllocations: mockFetchBudgetAllocations,
          createBudgetUseCase: mockUseCases.createBudgetUseCase,
          updateBudgetUseCase: mockUseCases.updateBudgetUseCase,
        );

    test('should create new instance when read', () {
      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(budgetProvider), isA<BudgetProvider>());
    });

    test('should create new budget provider with expected dependencies', () async {
      when(
        () => mockUseCases.createBudgetUseCase.call(
          userId: any(named: 'userId'),
          budget: any(named: 'budget'),
          activeBudgetPath: any(named: 'activeBudgetPath'),
          allocations: any(named: 'allocations'),
        ),
      ).thenAnswer((_) async => '1');

      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          activeBudgetProvider.overrideWith((_) => Stream<BudgetState>.value(dummyBudgetState)),
          selectedBudgetProvider('1').overrideWith((_) => Stream<BudgetState>.value(dummyBudgetState)),
        ],
      );
      addTearDown(container.dispose);

      final BudgetProvider provider = container.read(budgetProvider);

      expect(
        provider.create(
          fromBudgetId: '1',
          index: 1,
          title: 'title',
          amount: 1,
          description: 'description',
          startedAt: clock.now(),
          active: true,
        ),
        completion('1'),
      );
    });

    group('Create', () {
      test('should create new budget for user', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(mockFetchActiveBudgetPath.call).thenAnswer((_) async => 'path');
        when(() => mockFetchBudgetAllocations.call('1')).thenAnswer(
          (_) async => <ReferenceEntity, int>{
            const (id: '2', path: 'path'): 1,
          },
        );
        when(
          () => mockUseCases.createBudgetUseCase.call(
            userId: any(named: 'userId'),
            budget: any(named: 'budget'),
            activeBudgetPath: any(named: 'activeBudgetPath'),
            allocations: any(named: 'allocations'),
          ),
        ).thenAnswer((_) async => '1');

        final CreateBudgetData createBudgetData = CreateBudgetData(
          index: 1,
          title: 'title',
          description: 'description',
          amount: 1,
          startedAt: DateTime(0),
        );
        final String budgetId = await createProvider().create(
          index: 1,
          title: 'title',
          description: 'description',
          amount: 1,
          startedAt: DateTime(0),
          active: true,
          fromBudgetId: '1',
        );

        expect(budgetId, '1');
        verify(mockFetchUser.call).called(1);
        verify(mockFetchActiveBudgetPath.call).called(1);
        verify(
          () => mockUseCases.createBudgetUseCase.call(
            userId: dummyUser.id,
            budget: createBudgetData,
            activeBudgetPath: 'path',
            allocations: <ReferenceEntity, int>{
              const (id: '2', path: 'path'): 1,
            },
          ),
        ).called(1);
      });
    });

    group('Update', () {
      test('should update existing budget', () async {
        when(() => mockUseCases.updateBudgetUseCase.call(any())).thenAnswer((_) async => true);

        const UpdateBudgetData updateBudgetData = UpdateBudgetData(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          amount: 1,
          endedAt: null,
        );
        await createProvider().update(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          amount: 1,
        );

        verify(() => mockUseCases.updateBudgetUseCase.call(updateBudgetData)).called(1);
      });
    });
  });
}
