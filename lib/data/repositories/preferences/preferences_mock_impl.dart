import 'package:ovavue/domain.dart';

class PreferencesMockImpl implements PreferencesRepository {
  int? _themeMode;

  @override
  Future<String> fetchDatabaseLocation() async => 'db.sqlite';

  @override
  Future<bool> importDatabase() async => true;

  @override
  Future<bool> exportDatabase() async => true;

  @override
  Future<int?> fetchThemeMode() async => _themeMode;

  @override
  Future<bool> updateThemeMode(int themeMode) async {
    _themeMode = themeMode;
    return true;
  }
}
