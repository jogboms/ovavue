abstract class PreferencesRepository {
  Future<String> fetchDatabaseLocation();

  Future<bool?> importDatabase();

  Future<bool?> exportDatabase();
}
