import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mt;
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:registry/registry.dart';

import 'mocks.dart';

class MockRepositories {
  final AuthRepository auth = MockAuthRepository();
  final UsersRepository users = MockUsersRepository();
  final BudgetsRepository budgets = MockBudgetsRepository();
  final BudgetPlansRepository budgetPlans = MockBudgetPlansRepository();
  final BudgetCategoriesRepository budgetCategories = MockBudgetCategoriesRepository();
  final BudgetAllocationsRepository budgetAllocations = MockBudgetAllocationsRepository();
  final PreferencesRepository preferences = MockPreferencesRepository();

  void reset() =>
      <Object>[auth, users, budgets, budgetPlans, budgetCategories, budgetAllocations, preferences].forEach(mt.reset);
}

final MockRepositories mockRepositories = MockRepositories();

class MockUseCases {
  final CreateBudgetAllocationUseCase createBudgetAllocationUseCase = MockCreateBudgetAllocationUseCase();
  final CreateBudgetCategoryUseCase createBudgetCategoryUseCase = MockCreateBudgetCategoryUseCase();
  final CreateBudgetPlanUseCase createBudgetPlanUseCase = MockCreateBudgetPlanUseCase();
  final CreateBudgetUseCase createBudgetUseCase = MockCreateBudgetUseCase();
  final CreateUserUseCase createUserUseCase = MockCreateUserUseCase();
  final ActivateBudgetUseCase activateBudgetUseCase = MockActivateBudgetUseCase();
  final UpdateBudgetAllocationUseCase updateBudgetAllocationUseCase = MockUpdateBudgetAllocationUseCase();
  final UpdateBudgetCategoryUseCase updateBudgetCategoryUseCase = MockUpdateBudgetCategoryUseCase();
  final UpdateBudgetPlanUseCase updateBudgetPlanUseCase = MockUpdateBudgetPlanUseCase();
  final UpdateBudgetUseCase updateBudgetUseCase = MockUpdateBudgetUseCase();
  final DeleteBudgetAllocationUseCase deleteBudgetAllocationUseCase = MockDeleteBudgetAllocationUseCase();
  final DeleteBudgetCategoryUseCase deleteBudgetCategoryUseCase = MockDeleteBudgetCategoryUseCase();
  final DeleteBudgetPlanUseCase deleteBudgetPlanUseCase = MockDeleteBudgetPlanUseCase();
  final DeleteBudgetUseCase deleteBudgetUseCase = MockDeleteBudgetUseCase();
  final FetchAccountUseCase fetchAccountUseCase = MockFetchAccountUseCase();
  final FetchBudgetAllocationsByBudgetUseCase fetchBudgetAllocationsByBudgetUseCase =
      MockFetchBudgetAllocationsByBudgetUseCase();
  final FetchBudgetAllocationsByPlanUseCase fetchBudgetAllocationsByPlanUseCase =
      MockFetchBudgetAllocationsByPlanUseCase();
  final FetchBudgetCategoriesUseCase fetchBudgetCategoriesUseCase = MockFetchBudgetCategoriesUseCase();
  final FetchBudgetPlansUseCase fetchBudgetPlansUseCase = MockFetchBudgetPlansUseCase();
  final FetchBudgetUseCase fetchBudgetUseCase = MockFetchBudgetUseCase();
  final FetchBudgetsUseCase fetchBudgetsUseCase = MockFetchBudgetsUseCase();
  final FetchActiveBudgetUseCase fetchActiveBudgetUseCase = MockFetchActiveBudgetUseCase();
  final FetchUserUseCase fetchUserUseCase = MockFetchUserUseCase();
  final FetchDatabaseLocationUseCase fetchDatabaseLocationUseCase = MockFetchDatabaseLocationUseCase();

  void reset() => <Object>[
        createBudgetAllocationUseCase,
        createBudgetCategoryUseCase,
        createBudgetPlanUseCase,
        createBudgetUseCase,
        createUserUseCase,
        activateBudgetUseCase,
        updateBudgetAllocationUseCase,
        updateBudgetCategoryUseCase,
        updateBudgetPlanUseCase,
        updateBudgetUseCase,
        deleteBudgetAllocationUseCase,
        deleteBudgetCategoryUseCase,
        deleteBudgetPlanUseCase,
        deleteBudgetUseCase,
        fetchAccountUseCase,
        fetchBudgetAllocationsByPlanUseCase,
        fetchBudgetCategoriesUseCase,
        fetchBudgetPlansUseCase,
        fetchBudgetUseCase,
        fetchBudgetsUseCase,
        fetchActiveBudgetUseCase,
        fetchUserUseCase,
        fetchDatabaseLocationUseCase,
      ].forEach(mt.reset);
}

final MockUseCases mockUseCases = MockUseCases();

Registry createRegistry({
  Environment environment = Environment.testing,
}) =>
    Registry()
      ..set<Analytics>(FakeAnalytics())
      ..set(mockRepositories.auth)
      ..set(mockRepositories.users)
      ..set(mockRepositories.budgets)
      ..set(mockRepositories.budgetPlans)
      ..set(mockRepositories.budgetCategories)
      ..set(mockRepositories.budgetAllocations)
      ..set(mockRepositories.preferences)
      ..factory((RegistryFactory di) => CreateBudgetAllocationUseCase(allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetCategoryUseCase(categories: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetPlanUseCase(plans: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetUseCase(budgets: di(), allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => ActivateBudgetUseCase(budgets: di(), analytics: di()))
      ..factory((RegistryFactory di) => UpdateBudgetAllocationUseCase(allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => UpdateBudgetCategoryUseCase(categories: di(), analytics: di()))
      ..factory((RegistryFactory di) => UpdateBudgetPlanUseCase(plans: di(), analytics: di()))
      ..factory((RegistryFactory di) => UpdateBudgetUseCase(budgets: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateUserUseCase(users: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetAllocationUseCase(allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetCategoryUseCase(categories: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetPlanUseCase(plans: di(), allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetUseCase(budgets: di(), analytics: di()))
      ..factory((RegistryFactory di) => FetchAccountUseCase(auth: di()))
      ..factory((RegistryFactory di) => FetchBudgetAllocationsByBudgetUseCase(allocations: di()))
      ..factory((RegistryFactory di) => FetchBudgetAllocationsByPlanUseCase(allocations: di()))
      ..factory((RegistryFactory di) => FetchBudgetCategoriesUseCase(categories: di()))
      ..factory((RegistryFactory di) => FetchBudgetPlansUseCase(plans: di()))
      ..factory((RegistryFactory di) => FetchBudgetUseCase(budgets: di()))
      ..factory((RegistryFactory di) => FetchBudgetsUseCase(budgets: di()))
      ..factory((RegistryFactory di) => FetchActiveBudgetUseCase(budgets: di()))
      ..factory((RegistryFactory di) => FetchUserUseCase(users: di()))
      ..factory((RegistryFactory di) => FetchDatabaseLocationUseCase(preferences: di()))
      ..set(environment);

ProviderContainer createProviderContainer({
  ProviderContainer? parent,
  Registry? registry,
  List<Override>? overrides,
  List<ProviderObserver>? observers,
}) {
  final ProviderContainer container = ProviderContainer(
    parent: parent,
    overrides: <Override>[
      registryProvider.overrideWithValue(
        registry ?? createRegistry().withMockedUseCases(),
      ),
      ...?overrides,
    ],
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

Widget createApp({
  Widget? home,
  Registry? registry,
  List<Override>? overrides,
  List<NavigatorObserver>? observers,
  bool includeMaterial = true,
}) {
  registry ??= createRegistry();

  return ProviderScope(
    overrides: <Override>[
      registryProvider.overrideWithValue(registry),
      ...?overrides,
    ],
    child: App(
      registry: registry,
      navigatorObservers: observers,
      home: includeMaterial ? Material(child: home) : home,
    ),
  );
}

class ProviderListener<T> {
  final List<T> log = <T>[];

  void call(T? previous, T next) => log.add(next);

  void reset() => log.clear();
}

class LogAnalytics implements Analytics {
  final List<AnalyticsEvent> events = <AnalyticsEvent>[];
  String? userId;

  @override
  Future<void> log(AnalyticsEvent event) async => events.add(event);

  @override
  Future<void> setUserId(String id) async => userId = id;

  @override
  Future<void> removeUserId() async => userId = null;

  void reset() {
    events.clear();
    removeUserId();
  }

  @override
  Future<void> setCurrentScreen(String name) async {}
}

extension MockUseCasesExtensions on Registry {
  Registry withMockedUseCases() => this
    ..replace<CreateBudgetAllocationUseCase>(mockUseCases.createBudgetAllocationUseCase)
    ..replace<CreateBudgetCategoryUseCase>(mockUseCases.createBudgetCategoryUseCase)
    ..replace<CreateBudgetPlanUseCase>(mockUseCases.createBudgetPlanUseCase)
    ..replace<CreateBudgetUseCase>(mockUseCases.createBudgetUseCase)
    ..replace<CreateUserUseCase>(mockUseCases.createUserUseCase)
    ..replace<ActivateBudgetUseCase>(mockUseCases.activateBudgetUseCase)
    ..replace<UpdateBudgetPlanUseCase>(mockUseCases.updateBudgetPlanUseCase)
    ..replace<DeleteBudgetAllocationUseCase>(mockUseCases.deleteBudgetAllocationUseCase)
    ..replace<DeleteBudgetCategoryUseCase>(mockUseCases.deleteBudgetCategoryUseCase)
    ..replace<DeleteBudgetPlanUseCase>(mockUseCases.deleteBudgetPlanUseCase)
    ..replace<DeleteBudgetUseCase>(mockUseCases.deleteBudgetUseCase)
    ..replace<FetchAccountUseCase>(mockUseCases.fetchAccountUseCase)
    ..replace<FetchBudgetAllocationsByBudgetUseCase>(mockUseCases.fetchBudgetAllocationsByBudgetUseCase)
    ..replace<FetchBudgetAllocationsByPlanUseCase>(mockUseCases.fetchBudgetAllocationsByPlanUseCase)
    ..replace<FetchBudgetCategoriesUseCase>(mockUseCases.fetchBudgetCategoriesUseCase)
    ..replace<FetchBudgetPlansUseCase>(mockUseCases.fetchBudgetPlansUseCase)
    ..replace<FetchBudgetUseCase>(mockUseCases.fetchBudgetUseCase)
    ..replace<FetchBudgetsUseCase>(mockUseCases.fetchBudgetsUseCase)
    ..replace<FetchActiveBudgetUseCase>(mockUseCases.fetchActiveBudgetUseCase)
    ..replace<FetchUserUseCase>(mockUseCases.fetchUserUseCase)
    ..replace<FetchDatabaseLocationUseCase>(mockUseCases.fetchDatabaseLocationUseCase);
}

extension FinderExtensions on Finder {
  Finder descendantOf(Finder of) => find.descendant(of: of, matching: this);
}

extension WidgetTesterExtensions on WidgetTester {
  Future<void> verifyPushNavigation<U extends Widget>(NavigatorObserver observer) async {
    // NOTE: This is done for pages that show any indefinite animated loaders, CircularProgress
    await pump();
    await pump();

    mt.verify(() => observer.didPush(mt.any(), mt.any()));
    expect(find.byType(U), findsOneWidget);
  }

  Future<void> verifyPopNavigation(NavigatorObserver observer) async {
    // NOTE: This is done for pages that show any indefinite animated loaders, CircularProgress
    await pump();
    await pump();

    mt.verify(() => observer.didPop(mt.any(), mt.any()));
  }
}

extension VerificationResultExtension on VerificationResult {
  T capturedType<T>() => captured.first as T;
}
