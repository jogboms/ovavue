import 'package:ovavue/domain/repositories/preferences.dart';

class FetchThemeModeUseCase {
  const FetchThemeModeUseCase({
    required PreferencesRepository preferences,
  }) : _preferences = preferences;

  final PreferencesRepository _preferences;

  Future<int?> call() async => _preferences.fetchThemeMode();
}
