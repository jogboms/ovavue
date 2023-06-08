import 'dart:async';

abstract class ThemeModeStorage {
  FutureOr<int?> get();

  FutureOr<void> set(int themeMode);
}
