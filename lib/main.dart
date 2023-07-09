import 'dart:async' as async;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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
  final AuthIdentityStorage authIdentityStorage;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final NavigatorObserver navigationObserver = NavigatorObserver();
  final DeviceInformation deviceInformation = await AppDeviceInformation.initialize();
  final SharedPreferences storage = await SharedPreferences.getInstance();
  final _ThemeModeStorage themeModeStorage = _ThemeModeStorage(storage);
  final _DefaultBackupClientController backupClientController = _DefaultBackupClientController(
    navigatorKey: navigatorKey,
    storage: storage,
  );
  switch (environment) {
    case Environment.dev:
      authIdentityStorage = const _InMemoryAuthIdentityStorage();
      repository = _Repository.local(
        Database.memory(),
        authIdentityStorage: const _InMemoryAuthIdentityStorage(),
        preferences: PreferencesLocalImpl(themeModeStorage),
      );
      reporterClient = const _NoopReporterClient();
      analytics = const _PrintAnalytics();
      break;
    case Environment.prod:
      final PreferencesRepository preferences = PreferencesLocalImpl(themeModeStorage);
      authIdentityStorage = const _SecureStorageAuthIdentityStorage(FlutterSecureStorage());
      repository = _Repository.local(
        Database(await _LocalDatabaseUtility.location()),
        authIdentityStorage: authIdentityStorage,
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
      authIdentityStorage = const _InMemoryAuthIdentityStorage();
      repository = _Repository.mock(themeModeStorage: themeModeStorage);
      reporterClient = const _NoopReporterClient();
      analytics = const _PrintAnalytics();
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
    ..factory((RegistryFactory di) => FetchThemeModeUseCase(preferences: di()))
    ..factory((RegistryFactory di) => UpdateThemeModeUseCase(preferences: di()))

    /// Environment.
    ..set(environment);

  final String? accountKey = await authIdentityStorage.get();
  if (accountKey != null) {
    backupClientController.hydrate(accountKey);
  }

  runApp(
    ProviderScope(
      overrides: <Override>[
        registryProvider.overrideWithValue(registry),
        appVersionProvider.overrideWithValue(deviceInformation.appVersion),
        backupClientControllerProvider.overrideWithValue(backupClientController),
      ],
      child: ErrorBoundary(
        isReleaseMode: !environment.isDebugging,
        errorViewBuilder: (_) => const AppCrashErrorView(),
        onException: AppLog.e,
        onCrash: errorReporter.reportCrash,
        child: App(
          environment: environment,
          navigatorKey: navigatorKey,
          themeMode: (await themeModeStorage.get())?.themeMode,
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

  _Repository.mock({
    required ThemeModeStorage themeModeStorage,
  })  : auth = AuthMockImpl(),
        users = UsersMockImpl(),
        budgets = BudgetsMockImpl(),
        budgetPlans = BudgetPlansMockImpl(),
        budgetCategories = BudgetCategoriesMockImpl(),
        budgetAllocations = BudgetAllocationsMockImpl(),
        budgetMetadata = BudgetMetadataMockImpl(),
        preferences = PreferencesMockImpl(themeModeStorage);

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

class _DefaultBackupClientController implements BackupClientController {
  _DefaultBackupClientController({
    required GlobalKey<NavigatorState> navigatorKey,
    required SharedPreferences storage,
  })  : _navigatorKey = navigatorKey,
        _storage = storage {
    final String? clientName = storage.getString(_key);
    final BackupClientProvider? client = clientName != null ? backupClientProviderByName(clientName) : null;
    if (client == null && clientName != null) {
      AppLog.e('Could not find backup client with name: $clientName', StackTrace.current);
    }

    _client = client ?? defaultBackupClientProvider;
  }

  final GlobalKey<NavigatorState> _navigatorKey;
  final SharedPreferences _storage;
  static const String _key = 'ovavue.app.backup_client';

  @override
  Set<BackupClientProvider> get clients => backupClientProviders;

  @override
  BackupClientProvider get client => _client;
  late BackupClientProvider _client;

  void hydrate(String accountKey) => setup(client, accountKey);

  @override
  String displayName(BackupClientProvider client) {
    final Locale locale = Localizations.localeOf(_navigatorKey.currentContext!);
    return client.displayName(BackupClientLocale.from(locale));
  }

  @override
  Future<bool> setup(BackupClientProvider client, String accountKey) async {
    final async.Completer<bool> completer = async.Completer<bool>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool result = await client.setup(_navigatorKey.currentContext!, accountKey);
      if (result) {
        _client = client;
        await _storage.setString(_key, _client.name);
      }
      completer.complete(result);
    });

    return completer.future;
  }

  @override
  Future<bool> import() async => client.import(await _databaseFile());

  @override
  Future<bool> export() async => client.export(await _databaseFile());

  Future<io.File> _databaseFile() async => io.File(await _LocalDatabaseUtility.location());
}

class _LocalDatabaseUtility {
  static const String _dbName = 'db.sqlite';

  static Future<String> location() async => p.join(await _deriveDirectoryPath(), _dbName);

  static Future<String> _deriveDirectoryPath() =>
      (io.Platform.isIOS ? getLibraryDirectory() : getApplicationDocumentsDirectory()).then((_) => _.path);
}

extension on int {
  ThemeMode get themeMode => ThemeMode.values[this];
}
