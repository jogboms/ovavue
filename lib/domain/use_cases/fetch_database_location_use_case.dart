import '../repositories/preferences.dart';

class FetchDatabaseLocationUseCase {
  const FetchDatabaseLocationUseCase({
    required PreferencesRepository preferences,
  }) : _preferences = preferences;

  final PreferencesRepository _preferences;

  Future<String> call() async => _preferences.fetchDatabaseLocation();
}
