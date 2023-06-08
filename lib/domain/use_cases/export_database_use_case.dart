import '../repositories/preferences.dart';

class ExportDatabaseUseCase {
  const ExportDatabaseUseCase({
    required PreferencesRepository preferences,
  }) : _preferences = preferences;

  final PreferencesRepository _preferences;

  Future<bool> call() async => _preferences.exportDatabase();
}
