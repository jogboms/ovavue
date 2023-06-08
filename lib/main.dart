import 'dart:async' as async;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:registry/registry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart' as io;

import 'core.dart';
import 'data.dart';
import 'domain.dart';
import 'presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  enrichDefaultIntlSymbols();
  await findSystemLocale();

  final _Repository repository;
  final ReporterClient reporterClient;
  final Analytics analytics;
  final NavigatorObserver navigationObserver = NavigatorObserver();
  final DeviceInformation deviceInformation = await AppDeviceInformation.initialize();
  switch (environment) {
    case Environment.dev:
      repository = _Repository.local(
        Database.memory(),
        authIdentityStorage: const _InMemoryAuthIdentityStorage(),
        preferences: PreferencesLocalImpl(_ThemeModeStorage(await SharedPreferences.getInstance())),
      );
      reporterClient = const _NoopReporterClient();
      analytics = const _PrintAnalytics();
      break;
    case Environment.prod:
      final PreferencesRepository preferences = PreferencesLocalImpl(
        _ThemeModeStorage(await SharedPreferences.getInstance()),
      );
      repository = _Repository.local(
        Database(await preferences.fetchDatabaseLocation()),
        authIdentityStorage: const _SecureStorageAuthIdentityStorage(FlutterSecureStorage()),
        preferences: preferences,
      );
      reporterClient = _ReporterClient(
        deviceInformation: deviceInformation,
        environment: environment,
      );
      analytics = _InMemoryAnalytics();
      break;
    case Environment.testing:
    case Environment.mock:
      seedMockData();
      analytics = const _PrintAnalytics();
      repository = _Repository.mock();
      reporterClient = const _NoopReporterClient();
      break;
  }

  final ErrorReporter errorReporter = ErrorReporter(client: reporterClient);
  AppLog.init(
    logFilter: () => kDebugMode && !environment.isTesting,
    exceptionFilter: (Object error) {
      const List<Type> ignoreTypes = <Type>[
        io.SocketException,
        io.HandshakeException,
        async.TimeoutException,
      ];
      return !kDebugMode && !ignoreTypes.contains(error.runtimeType);
    },
    onException: errorReporter.report,
    onLog: (Object? message) => debugPrint(message?.toString()),
  );

  final Registry registry = Registry()

    /// Analytics.
    ..set(analytics)

    /// Repositories.
    /// Do not use directly within the app.
    /// Added to Registry only for convenience with the UseCase factories.
    ..set(repository.auth)
    ..set(repository.users)
    ..set(repository.budgets)
    ..set(repository.budgetPlans)
    ..set(repository.budgetCategories)
    ..set(repository.budgetAllocations)
    ..set(repository.budgetMetadata)
    ..set(repository.preferences)

    /// UseCases.
    /// Callable classes that may contain logic or else route directly to repositories.
    ..factory((RegistryFactory di) => CreateBudgetAllocationUseCase(allocations: di(), analytics: di()))
    ..factory((RegistryFactory di) => CreateBudgetCategoryUseCase(categories: di(), analytics: di()))
    ..factory((RegistryFactory di) => CreateBudgetPlanUseCase(plans: di(), analytics: di()))
    ..factory((RegistryFactory di) => CreateBudgetMetadataUseCase(metadata: di(), analytics: di()))
    ..factory((RegistryFactory di) => CreateBudgetUseCase(budgets: di(), allocations: di(), analytics: di()))
    ..factory((RegistryFactory di) => CreateUserUseCase(users: di(), analytics: di()))
    ..factory((RegistryFactory di) => ActivateBudgetUseCase(budgets: di(), analytics: di()))
    ..factory((RegistryFactory di) => UpdateBudgetAllocationUseCase(allocations: di(), analytics: di()))
    ..factory((RegistryFactory di) => UpdateBudgetCategoryUseCase(categories: di(), analytics: di()))
    ..factory((RegistryFactory di) => UpdateBudgetPlanUseCase(plans: di(), analytics: di()))
    ..factory((RegistryFactory di) => UpdateBudgetMetadataUseCase(metadata: di(), analytics: di()))
    ..factory((RegistryFactory di) => UpdateBudgetUseCase(budgets: di(), analytics: di()))
    ..factory((RegistryFactory di) => DeleteBudgetAllocationUseCase(allocations: di(), analytics: di()))
    ..factory((RegistryFactory di) => DeleteBudgetCategoryUseCase(categories: di(), analytics: di()))
    ..factory((RegistryFactory di) => DeleteBudgetPlanUseCase(plans: di(), allocations: di(), analytics: di()))
    ..factory((RegistryFactory di) => DeleteBudgetUseCase(budgets: di(), analytics: di()))
    ..factory((RegistryFactory di) => AddMetadataToPlanUseCase(metadata: di(), analytics: di()))
    ..factory((RegistryFactory di) => RemoveMetadataFromPlanUseCase(metadata: di(), analytics: di()))
    ..factory((RegistryFactory di) => FetchAccountUseCase(auth: di()))
    ..factory((RegistryFactory di) => FetchBudgetAllocationsByBudgetUseCase(allocations: di()))
    ..factory((RegistryFactory di) => FetchBudgetAllocationsByPlanUseCase(allocations: di()))
    ..factory((RegistryFactory di) => FetchBudgetCategoriesUseCase(categories: di()))
    ..factory((RegistryFactory di) => FetchBudgetPlansUseCase(plans: di()))
    ..factory((RegistryFactory di) => FetchBudgetPlansByMetadataUseCase(plans: di(), metadata: di()))
    ..factory((RegistryFactory di) => FetchBudgetMetadataUseCase(metadata: di()))
    ..factory((RegistryFactory di) => FetchBudgetMetadataByPlanUseCase(metadata: di()))
    ..factory((RegistryFactory di) => FetchBudgetUseCase(budgets: di()))
    ..factory((RegistryFactory di) => FetchBudgetsUseCase(budgets: di()))
    ..factory((RegistryFactory di) => FetchActiveBudgetUseCase(budgets: di()))
    ..factory((RegistryFactory di) => FetchUserUseCase(users: di()))
    ..factory((RegistryFactory di) => FetchDatabaseLocationUseCase(preferences: di()))
    ..factory((RegistryFactory di) => FetchThemeModeUseCase(preferences: di()))
    ..factory((RegistryFactory di) => UpdateThemeModeUseCase(preferences: di()))
    ..factory((RegistryFactory di) => ImportDatabaseUseCase(preferences: di()))
    ..factory((RegistryFactory di) => ExportDatabaseUseCase(preferences: di()))

    /// Environment.
    ..set(environment);

  runApp(
    ProviderScope(
      overrides: <Override>[
        registryProvider.overrideWithValue(registry),
        appVersionProvider.overrideWithValue(deviceInformation.appVersion),
      ],
      child: ErrorBoundary(
        isReleaseMode: !environment.isDebugging,
        errorViewBuilder: (_) => const AppCrashErrorView(),
        onException: AppLog.e,
        onCrash: errorReporter.reportCrash,
        child: App(
          registry: registry,
          navigatorObservers: <NavigatorObserver>[navigationObserver],
        ),
      ),
    ),
  );
}

class _Repository {
  _Repository.local(
    Database db, {
    required AuthIdentityStorage authIdentityStorage,
    required this.preferences,
  })  : auth = AuthLocalImpl(db, authIdentityStorage),
        users = UsersLocalImpl(db),
        budgets = BudgetsLocalImpl(db),
        budgetPlans = BudgetPlansLocalImpl(db),
        budgetCategories = BudgetCategoriesLocalImpl(db),
        budgetAllocations = BudgetAllocationsLocalImpl(db),
        budgetMetadata = BudgetMetadataLocalImpl(db);

  _Repository.mock()
      : auth = AuthMockImpl(),
        users = UsersMockImpl(),
        budgets = BudgetsMockImpl(),
        budgetPlans = BudgetPlansMockImpl(),
        budgetCategories = BudgetCategoriesMockImpl(),
        budgetAllocations = BudgetAllocationsMockImpl(),
        budgetMetadata = BudgetMetadataMockImpl(),
        preferences = PreferencesMockImpl();

  final AuthRepository auth;
  final UsersRepository users;
  final BudgetsRepository budgets;
  final BudgetPlansRepository budgetPlans;
  final BudgetCategoriesRepository budgetCategories;
  final BudgetAllocationsRepository budgetAllocations;
  final BudgetMetadataRepository budgetMetadata;
  final PreferencesRepository preferences;
}

class _ReporterClient implements ReporterClient {
  _ReporterClient({
    required this.deviceInformation,
    required this.environment,
  });

  final DeviceInformation deviceInformation;
  final Environment environment;
  final Set<_ReporterErrorEvent> _events = <_ReporterErrorEvent>{};

  @override
  async.FutureOr<void> report({required StackTrace stackTrace, required Object error, Object? extra}) async {
    _events.add(
      (
        error: error,
        stackTrace: stackTrace,
        environment: environment.name.toUpperCase(),
        deviceInformation: deviceInformation.toMap(),
        extra: extra is Map ? extra as Map<String, dynamic>? : <String, dynamic>{'extra': extra},
      ),
    );
  }

  @override
  // TODO(Jogboms): handle crash
  async.FutureOr<void> reportCrash(FlutterErrorDetails details) {}

  @override
  void log(Object object) => AppLog.i(object);
}

typedef _ReporterErrorEvent = ({
  Object error,
  StackTrace stackTrace,
  String environment,
  Map<String, String> deviceInformation,
  Map<String, dynamic>? extra,
});

class _NoopReporterClient implements ReporterClient {
  const _NoopReporterClient();

  @override
  async.FutureOr<void> report({required StackTrace stackTrace, required Object error, Object? extra}) {}

  @override
  async.FutureOr<void> reportCrash(FlutterErrorDetails details) {}

  @override
  void log(Object object) {}
}

class _PrintAnalytics implements Analytics {
  const _PrintAnalytics();

  @override
  Future<void> log(AnalyticsEvent event) async => AppLog.i(event);

  @override
  Future<void> setCurrentScreen(String name) async => AppLog.i('screen_view: $name');

  @override
  async.Future<void> removeUserId() async {}

  @override
  async.Future<void> setUserId(String id) async {}
}

class _InMemoryAnalytics implements Analytics {
  // ignore: unused_field, use_late_for_private_fields_and_variables
  String? _screenName;
  final Set<AnalyticsEvent> _events = <AnalyticsEvent>{};

  @override
  Future<void> log(AnalyticsEvent event) async => _events.add(event);

  @override
  Future<void> setCurrentScreen(String name) async => _screenName = name;

  @override
  async.Future<void> removeUserId() async {}

  @override
  async.Future<void> setUserId(String id) async {}
}

class _SecureStorageAuthIdentityStorage implements AuthIdentityStorage {
  const _SecureStorageAuthIdentityStorage(this._storage);

  final FlutterSecureStorage _storage;
  static const String _key = 'ovavue.app.auth.identity';

  @override
  async.FutureOr<String?> get() => _storage.read(key: _key);

  @override
  async.FutureOr<void> set(String id) => _storage.write(key: _key, value: id);
}

class _InMemoryAuthIdentityStorage implements AuthIdentityStorage {
  const _InMemoryAuthIdentityStorage();

  @override
  async.FutureOr<String?> get() => 'id';

  @override
  async.FutureOr<void> set(String id) {}
}

class _ThemeModeStorage implements ThemeModeStorage {
  const _ThemeModeStorage(this._storage);

  final SharedPreferences _storage;
  static const String _key = 'ovavue.app.theme_mode';

  @override
  async.FutureOr<int?> get() => _storage.getInt(_key);

  @override
  async.FutureOr<void> set(int themeMode) => _storage.setInt(_key, themeMode);
}
