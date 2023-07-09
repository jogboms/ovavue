import 'dart:async' as async;

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/core.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart' as io;

import '../utils.dart';
import 'backup_client_provider.dart';

const BackupClientProvider defaultBackupClientProvider = _FileSystemClientProvider();
const Set<BackupClientProvider> backupClientProviders = <BackupClientProvider>{
  defaultBackupClientProvider,
  _CloudClientProvider(),
};

BackupClientProvider? backupClientProviderByName(String name) {
  return backupClientProviders.firstWhereOrNull(
    (_) => _.name == name,
  );
}

class _FileSystemClientProvider implements BackupClientProvider {
  const _FileSystemClientProvider();

  static const String _backupDbName = 'backup.sqlite';

  @override
  String get name => 'fileSystem';

  @override
  String displayName(BackupClientLocale locale) => switch (locale) {
        BackupClientLocale.en => 'File system',
      };

  @override
  async.Future<bool> setup(BuildContext context, String accountKey) async => true;

  @override
  async.Future<bool> import(io.File databaseFile) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return false;
    }
    final String? newDbFilePath = result.files.first.path;
    if (newDbFilePath == null) {
      return false;
    }

    try {
      final io.File newDbFile = io.File(newDbFilePath);

      final String directoryPath = p.dirname(databaseFile.path);
      databaseFile.renameSync(p.join(directoryPath, _backupDbName));
      newDbFile.copySync(databaseFile.path);
      return true;
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return false;
    }
  }

  @override
  async.Future<bool> export(io.File databaseFile) async {
    try {
      final String tempPath = p.join(
        (await getTemporaryDirectory()).path,
        clock.now().format(DateTimeFormat.dottedIntFull),
      );
      await databaseFile.copy(tempPath);

      await Share.shareXFiles(<XFile>[
        XFile(tempPath),
      ]);
      return true;
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return false;
    }
  }
}

class _CloudClientProvider implements BackupClientProvider {
  const _CloudClientProvider();

  @override
  String get name => 'cloud';

  @override
  String displayName(BackupClientLocale locale) => switch (locale) {
        BackupClientLocale.en => 'Cloud storage (coming soon)',
      };

  @override
  async.Future<bool> setup(BuildContext context, String accountKey) async {
    // TODO(jogboms): implement cloud storage
    return true;
  }

  @override
  async.Future<bool> import(io.File databaseFile) async => false;

  @override
  async.Future<bool> export(io.File databaseFile) async => false;
}
