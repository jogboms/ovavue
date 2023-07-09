abstract class PreferencesRepository {
  Future<int?> fetchThemeMode();

  Future<bool> updateThemeMode(int themeMode);
}
