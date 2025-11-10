import 'dart:async';

import 'package:ovavue/data/repositories/preferences/theme_mode_storage.dart';
import 'package:ovavue/domain.dart';

class PreferencesLocalImpl implements PreferencesRepository {
  const PreferencesLocalImpl(this._themeModeStorage);

  final ThemeModeStorage _themeModeStorage;

  @override
  Future<int?> fetchThemeMode() async => _themeModeStorage.get();

  @override
  Future<bool> updateThemeMode(int themeMode) async {
    await _themeModeStorage.set(themeMode);
    return true;
  }
}
