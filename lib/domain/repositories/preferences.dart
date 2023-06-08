abstract class PreferencesRepository {
  Future<String> fetchDatabaseLocation();

  Future<bool> importDatabase();

  Future<bool> exportDatabase();

  Future<int?> fetchThemeMode();

  Future<bool> updateThemeMode(int themeMode);
}
