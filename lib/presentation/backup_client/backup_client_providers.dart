import 'dart:async' as async;

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/presentation/backup_client/backup_client_provider.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart' as io;

const BackupClientProvider defaultBackupClientProvider = _FileSystemClientProvider();
const backupClientProviders = <BackupClientProvider>{
  defaultBackupClientProvider,
  _CloudClientProvider(),
};

BackupClientProvider? backupClientProviderByName(String name) => backupClientProviders.firstWhereOrNull(
  (BackupClientProvider e) => e.name == name,
);

class _FileSystemClientProvider implements BackupClientProvider {
  const _FileSystemClientProvider();

  @override
  String get name => 'fileSystem';

  @override
  String displayName(BackupClientLocale locale) => switch (locale) {
    BackupClientLocale.en => 'File system',
  };

  @override
  async.Future<BackupClientResult> setup(BuildContext context, String accountKey) async => BackupClientResult.success;

  @override
  async.Future<BackupClientResult> import(io.File databaseFile) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return BackupClientResult.dismissed;
    }
    final newDbFilePath = result.files.first.path;
    if (newDbFilePath == null) {
      return BackupClientResult.dismissed;
    }

    try {
      final directoryPath = p.dirname(databaseFile.path);
      databaseFile.renameSync(p.join(directoryPath, 'backup${p.extension(databaseFile.path)}'));

      io.File(newDbFilePath).copySync(databaseFile.path);
      return BackupClientResult.success;
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return BackupClientResult.failure;
    }
  }

  @override
  async.Future<BackupClientResult> export(io.File databaseFile) async {
    try {
      final tempPath = p.join(
        (await getTemporaryDirectory()).path,
        '${clock.now().format(DateTimeFormat.dottedIntFull)}${p.extension(databaseFile.path)}',
      );
      await databaseFile.copy(tempPath);

      final result = await Share.shareXFiles(<XFile>[
        XFile(tempPath),
      ]);
      return switch (result.status) {
        ShareResultStatus.success => BackupClientResult.success,
        ShareResultStatus.unavailable => BackupClientResult.failure,
        ShareResultStatus.dismissed => BackupClientResult.dismissed,
      };
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return BackupClientResult.failure;
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
  // TODO(jogboms): implement cloud storage
  async.Future<BackupClientResult> setup(BuildContext context, String accountKey) async =>
      BackupClientResult.unavailable;

  @override
  async.Future<BackupClientResult> import(io.File databaseFile) async => BackupClientResult.unavailable;

  @override
  async.Future<BackupClientResult> export(io.File databaseFile) async => BackupClientResult.unavailable;
}
