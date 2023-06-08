import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart' as io;

class PreferencesLocalImpl implements PreferencesRepository {
  const PreferencesLocalImpl(this._themeModeStorage);

  static const String _dbName = 'db.sqlite';
  static const String _backupDbName = 'backup.sqlite';

  final ThemeModeStorage _themeModeStorage;

  @override
  Future<String> fetchDatabaseLocation() async => _deriveDbFilePath(await _deriveDbDirectoryPath());

  @override
  Future<bool> importDatabase() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return false;
    }
    final String? newDbFilePath = result.files.first.path;
    if (newDbFilePath == null) {
      return false;
    }

    try {
      final io.File currentDbFile = io.File(await fetchDatabaseLocation());
      final io.File newDbFile = io.File(newDbFilePath);

      final String directoryPath = await _deriveDbDirectoryPath();
      currentDbFile.renameSync(p.join(directoryPath, _backupDbName));
      newDbFile.copySync(_deriveDbFilePath(directoryPath));
      return true;
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return false;
    }
  }

  @override
  Future<bool> exportDatabase() async {
    await Share.shareXFiles(<XFile>[
      XFile(await fetchDatabaseLocation()),
    ]);
    return true;
  }

  Future<String> _deriveDbDirectoryPath() =>
      (io.Platform.isIOS ? getLibraryDirectory() : getApplicationDocumentsDirectory()).then((_) => _.path);

  String _deriveDbFilePath(String directoryPath) => p.join(directoryPath, _dbName);

  @override
  Future<int?> fetchThemeMode() async => _themeModeStorage.get();

  @override
  Future<bool> updateThemeMode(int themeMode) async {
    await _themeModeStorage.set(themeMode);
    return true;
  }
}

abstract class ThemeModeStorage {
  FutureOr<int?> get();

  FutureOr<void> set(int themeMode);
}
