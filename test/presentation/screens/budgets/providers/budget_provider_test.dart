import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart' hide BudgetPlanAllocationViewModelExtension;

import '../../../../mocks.dart';
import '../../../../utils.dart';

Future<void> main() async {
  group('BudgetProvider', () {
    final mockFetchUser = MockAsyncCallback<UserEntity>();
    final MockAsyncCallback<ReferenceEntity?> mockFetchActiveBudgetReference = MockAsyncCallback<ReferenceEntity>();
    final mockFetchBudgetAllocations = MockAsyncCallbackValueChanged<PlanToAllocationMap, String>();

    final dummyUser = UsersMockImpl.user;
    final dummyBudget = BudgetsMockImpl.generateBudget();
    final dummyBudgetPlan = BudgetPlansMockImpl.generatePlan(id: '1');
    final dummyBudgetCategory = BudgetCategoriesMockImpl.generateCategory(id: '1');
    final dummyAllocation = BudgetAllocationsMockImpl.generateAllocation(
      id: '1',
      plan: dummyBudgetPlan,
      budget: dummyBudget,
    );
    final dummyBudgetState = BudgetState(
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
      registerFallbackValue((id: '1', path: 'path'));
      registerFallbackValue(FakeCreateBudgetData());
      registerFallbackValue(FakeUpdateBudgetData());
    });

    tearDown(() {
      reset(mockFetchUser);
      reset(mockFetchActiveBudgetReference);
      reset(mockFetchBudgetAllocations);
      mockUseCases.reset();
    });

    BudgetProviderState createProvider() => BudgetProviderState(
      fetchUser: mockFetchUser.call,
      fetchActiveBudgetReference: mockFetchActiveBudgetReference.call,
      fetchBudgetAllocations: mockFetchBudgetAllocations.call,
      createBudgetUseCase: mockUseCases.createBudgetUseCase,
      activateBudgetUseCase: mockUseCases.activateBudgetUseCase,
      updateBudgetUseCase: mockUseCases.updateBudgetUseCase,
    );

    test('should create new instance when read', () {
      final container = createProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(budgetProvider), isA<BudgetProvider>());
    });

    test('should create new budget provider with expected dependencies', () async {
      when(
        () => mockUseCases.createBudgetUseCase.call(
          userId: any(named: 'userId'),
          budget: any(named: 'budget'),
          activeBudgetReference: any(named: 'activeBudgetReference'),
          allocations: any(named: 'allocations'),
        ),
      ).thenAnswer((_) async => '1');

      final container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
          activeBudgetProvider.overrideWith((_) => Stream<BudgetState>.value(dummyBudgetState)),
          selectedBudgetProvider('1').overrideWith((_) => Stream<BudgetState>.value(dummyBudgetState)),
        ],
      );
      addTearDown(container.dispose);

      final provider = container.read(budgetProvider);

      expect(
        provider.create(
          fromBudgetId: '1',
          index: 1,
          title: 'title',
          amount: 1,
          description: 'description',
          startedAt: clock.now(),
          endedAt: null,
          active: true,
        ),
        completion('1'),
      );
    });

    group('Create', () {
      test('should create new budget for user', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(mockFetchActiveBudgetReference.call).thenAnswer((_) async => (id: '1', path: 'path'));
        when(() => mockFetchBudgetAllocations.call('1')).thenAnswer(
          (_) async => <ReferenceEntity, int>{
            const (id: '2', path: 'path'): 1,
          },
        );
        when(
          () => mockUseCases.createBudgetUseCase.call(
            userId: any(named: 'userId'),
            budget: any(named: 'budget'),
            activeBudgetReference: any(named: 'activeBudgetReference'),
            allocations: any(named: 'allocations'),
          ),
        ).thenAnswer((_) async => '1');

        final createBudgetData = CreateBudgetData(
          index: 1,
          title: 'title',
          description: 'description',
          amount: 1,
          active: true,
          startedAt: DateTime(0),
          endedAt: null,
        );
        final budgetId = await createProvider().create(
          index: 1,
          title: 'title',
          description: 'description',
          amount: 1,
          startedAt: DateTime(0),
          active: true,
          fromBudgetId: '1',
          endedAt: null,
        );

        expect(budgetId, '1');
        verify(mockFetchUser.call).called(1);
        verify(mockFetchActiveBudgetReference.call).called(1);
        verify(
          () => mockUseCases.createBudgetUseCase.call(
            userId: dummyUser.id,
            budget: createBudgetData,
            activeBudgetReference: (id: '1', path: 'path'),
            allocations: <ReferenceEntity, int>{
              const (id: '2', path: 'path'): 1,
            },
          ),
        ).called(1);
      });
    });

    group('Activate', () {
      test('should activate existing budget', () async {
        when(mockFetchUser.call).thenAnswer((_) async => dummyUser);
        when(mockFetchActiveBudgetReference.call).thenAnswer((_) async => (id: '1', path: 'path'));
        when(
          () => mockUseCases.activateBudgetUseCase.call(
            userId: any(named: 'userId'),
            reference: any(named: 'reference'),
            activeBudgetReference: any(named: 'activeBudgetReference'),
          ),
        ).thenAnswer((_) async => true);

        await createProvider().activate(id: '2', path: 'path');

        verify(mockFetchUser.call).called(1);
        verify(mockFetchActiveBudgetReference.call).called(1);
        verify(
          () => mockUseCases.activateBudgetUseCase.call(
            userId: dummyUser.id,
            reference: (id: '2', path: 'path'),
            activeBudgetReference: (id: '1', path: 'path'),
          ),
        ).called(1);
      });
    });

    group('Update', () {
      test('should update existing budget', () async {
        when(() => mockUseCases.updateBudgetUseCase.call(any())).thenAnswer((_) async => true);

        final updateBudgetData = UpdateBudgetData(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          amount: 1,
          active: true,
          startedAt: DateTime(0),
          endedAt: null,
        );
        await createProvider().update(
          id: '1',
          path: 'path',
          title: 'title',
          description: 'description',
          amount: 1,
          active: true,
          startedAt: DateTime(0),
          endedAt: null,
        );

        verify(() => mockUseCases.updateBudgetUseCase.call(updateBudgetData)).called(1);
      });
    });
  });
}
