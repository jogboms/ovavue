import 'package:ovavue/data/repositories/preferences/theme_mode_storage.dart';
import 'package:ovavue/domain.dart';

class PreferencesMockImpl implements PreferencesRepository {
  PreferencesMockImpl(this._themeModeStorage);

  final ThemeModeStorage _themeModeStorage;

  @override
  Future<int?> fetchThemeMode() async => _themeModeStorage.get();

  @override
  Future<bool> updateThemeMode(int themeMode) async {
    await _themeModeStorage.set(themeMode);
    return true;
  }
}
