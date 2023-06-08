import '../repositories/preferences.dart';

class UpdateThemeModeUseCase {
  const UpdateThemeModeUseCase({
    required PreferencesRepository preferences,
  }) : _preferences = preferences;

  final PreferencesRepository _preferences;

  Future<bool> call(int themeMode) async => _preferences.updateThemeMode(themeMode);
}
