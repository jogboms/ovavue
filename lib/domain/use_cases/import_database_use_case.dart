import '../repositories/preferences.dart';

class ImportDatabaseUseCase {
  const ImportDatabaseUseCase({
    required PreferencesRepository preferences,
  }) : _preferences = preferences;

  final PreferencesRepository _preferences;

  Future<bool?> call() async => _preferences.importDatabase();
}
