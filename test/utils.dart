import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mt;
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

  void reset() => <Object>[auth, users].forEach(mt.reset);
}

final MockRepositories mockRepositories = MockRepositories();

class MockUseCases {
  final CreateBudgetAllocationUseCase createBudgetAllocationUseCase = MockCreateBudgetAllocationUseCase();
  final CreateBudgetCategoryUseCase createBudgetCategoryUseCase = MockCreateBudgetCategoryUseCase();
  final CreateBudgetPlanUseCase createBudgetPlanUseCase = MockCreateBudgetPlanUseCase();
  final CreateBudgetUseCase createBudgetUseCase = MockCreateBudgetUseCase();
  final CreateUserUseCase createUserUseCase = MockCreateUserUseCase();
  final DeleteBudgetAllocationUseCase deleteBudgetAllocationUseCase = MockDeleteBudgetAllocationUseCase();
  final DeleteBudgetCategoryUseCase deleteBudgetCategoryUseCase = MockDeleteBudgetCategoryUseCase();
  final DeleteBudgetPlanUseCase deleteBudgetPlanUseCase = MockDeleteBudgetPlanUseCase();
  final DeleteBudgetUseCase deleteBudgetUseCase = MockDeleteBudgetUseCase();
  final FetchAccountUseCase fetchAccountUseCase = MockFetchAccountUseCase();
  final FetchBudgetAllocationsUseCase fetchBudgetAllocationsUseCase = MockFetchBudgetAllocationsUseCase();
  final FetchBudgetCategoriesUseCase fetchBudgetCategoriesUseCase = MockFetchBudgetCategoriesUseCase();
  final FetchBudgetPlansUseCase fetchBudgetPlansUseCase = MockFetchBudgetPlansUseCase();
  final FetchBudgetsUseCase fetchBudgetsUseCase = MockFetchBudgetsUseCase();
  final FetchActiveBudgetUseCase fetchActiveBudgetUseCase = MockFetchActiveBudgetUseCase();
  final FetchUserUseCase fetchUserUseCase = MockFetchUserUseCase();
  final SignInUseCase signInUseCase = MockSignInUseCase();
  final SignOutUseCase signOutUseCase = MockSignOutUseCase();
  final UpdateUserUseCase updateUserUseCase = MockUpdateUserUseCase();

  void reset() => <Object>[
        createBudgetAllocationUseCase,
        createBudgetCategoryUseCase,
        createBudgetPlanUseCase,
        createBudgetUseCase,
        createUserUseCase,
        deleteBudgetAllocationUseCase,
        deleteBudgetCategoryUseCase,
        deleteBudgetPlanUseCase,
        deleteBudgetUseCase,
        fetchAccountUseCase,
        fetchBudgetAllocationsUseCase,
        fetchBudgetCategoriesUseCase,
        fetchBudgetPlansUseCase,
        fetchBudgetsUseCase,
        fetchActiveBudgetUseCase,
        fetchUserUseCase,
        signInUseCase,
        signOutUseCase,
        updateUserUseCase,
      ].forEach(mt.reset);
}

final MockUseCases mockUseCases = MockUseCases();

Registry createRegistry({
  Environment environment = Environment.testing,
}) =>
    Registry()
      ..set<Analytics>(const NoopAnalytics())
      ..set(mockRepositories.auth)
      ..set(mockRepositories.users)
      ..set(mockRepositories.budgets)
      ..set(mockRepositories.budgetPlans)
      ..set(mockRepositories.budgetCategories)
      ..set(mockRepositories.budgetAllocations)
      ..factory((RegistryFactory di) => CreateBudgetAllocationUseCase(allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetCategoryUseCase(categories: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetPlanUseCase(plans: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateBudgetUseCase(budgets: di(), analytics: di()))
      ..factory((RegistryFactory di) => CreateUserUseCase(users: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetAllocationUseCase(allocations: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetCategoryUseCase(categories: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetPlanUseCase(plans: di(), analytics: di()))
      ..factory((RegistryFactory di) => DeleteBudgetUseCase(budgets: di(), analytics: di()))
      ..factory((RegistryFactory di) => FetchAccountUseCase(auth: di()))
      ..factory(
        (RegistryFactory di) => FetchBudgetAllocationsUseCase(
          allocations: di(),
          budgets: di(),
          plans: di(),
          categories: di(),
        ),
      )
      ..factory((RegistryFactory di) => FetchBudgetCategoriesUseCase(categories: di()))
      ..factory((RegistryFactory di) => FetchBudgetPlansUseCase(plans: di(), categories: di()))
      ..factory(
        (RegistryFactory di) => FetchBudgetsUseCase(
          budgets: di(),
          plans: di(),
          categories: di(),
        ),
      )
      ..factory(
        (RegistryFactory di) => FetchActiveBudgetUseCase(
          budgets: di(),
          plans: di(),
          categories: di(),
        ),
      )
      ..factory((RegistryFactory di) => FetchUserUseCase(users: di()))
      ..factory((RegistryFactory di) => SignInUseCase(auth: di(), analytics: di()))
      ..factory((RegistryFactory di) => SignOutUseCase(auth: di(), analytics: di()))
      ..factory((RegistryFactory di) => UpdateUserUseCase(users: di()))
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

class LogAnalytics extends NoopAnalytics {
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
}

extension MockUseCasesExtensions on Registry {
  Registry withMockedUseCases() => this
    ..replace<CreateBudgetAllocationUseCase>(mockUseCases.createBudgetAllocationUseCase)
    ..replace<CreateBudgetCategoryUseCase>(mockUseCases.createBudgetCategoryUseCase)
    ..replace<CreateBudgetPlanUseCase>(mockUseCases.createBudgetPlanUseCase)
    ..replace<CreateBudgetUseCase>(mockUseCases.createBudgetUseCase)
    ..replace<CreateUserUseCase>(mockUseCases.createUserUseCase)
    ..replace<DeleteBudgetAllocationUseCase>(mockUseCases.deleteBudgetAllocationUseCase)
    ..replace<DeleteBudgetCategoryUseCase>(mockUseCases.deleteBudgetCategoryUseCase)
    ..replace<DeleteBudgetPlanUseCase>(mockUseCases.deleteBudgetPlanUseCase)
    ..replace<DeleteBudgetUseCase>(mockUseCases.deleteBudgetUseCase)
    ..replace<FetchAccountUseCase>(mockUseCases.fetchAccountUseCase)
    ..replace<FetchBudgetAllocationsUseCase>(mockUseCases.fetchBudgetAllocationsUseCase)
    ..replace<FetchBudgetCategoriesUseCase>(mockUseCases.fetchBudgetCategoriesUseCase)
    ..replace<FetchBudgetPlansUseCase>(mockUseCases.fetchBudgetPlansUseCase)
    ..replace<FetchBudgetsUseCase>(mockUseCases.fetchBudgetsUseCase)
    ..replace<FetchActiveBudgetUseCase>(mockUseCases.fetchActiveBudgetUseCase)
    ..replace<FetchUserUseCase>(mockUseCases.fetchUserUseCase)
    ..replace<SignInUseCase>(mockUseCases.signInUseCase)
    ..replace<SignOutUseCase>(mockUseCases.signOutUseCase)
    ..replace<UpdateUserUseCase>(mockUseCases.updateUserUseCase);
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

extension NormalizedBudgetEntityExtensions on NormalizedBudgetEntity {
  BudgetEntity get asBudgetEntity => BudgetEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        amount: amount,
        startedAt: startedAt,
        endedAt: endedAt,
        plans: plans.map((NormalizedBudgetPlanEntity element) => element.reference).toList(growable: false),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension NormalizedBudgetEntityListExtensions on NormalizedBudgetEntityList {
  BudgetEntityList get asBudgetEntityList =>
      map((NormalizedBudgetEntity e) => e.asBudgetEntity).toList(growable: false);
}

extension NormalizedBudgetPlanEntityExtensions on NormalizedBudgetPlanEntity {
  BudgetPlanEntity get asBudgetPlanEntity => BudgetPlanEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        category: category.reference,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension NormalizedBudgetPlanEntityListExtensions on NormalizedBudgetPlanEntityList {
  BudgetPlanEntityList get asBudgetPlanEntityList =>
      map((NormalizedBudgetPlanEntity e) => e.asBudgetPlanEntity).toList(growable: false);
}

extension NormalizedBudgetAllocationEntityListExtensions on NormalizedBudgetAllocationEntityList {
  BudgetAllocationEntityList get asBudgetAllocationEntityList => map(
        (NormalizedBudgetAllocationEntity e) => BudgetAllocationEntity(
          id: e.id,
          path: e.path,
          amount: e.amount,
          startedAt: e.startedAt,
          endedAt: e.endedAt,
          budget: e.budget.reference,
          plan: e.plan.reference,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
        ),
      ).toList(growable: false);
}
