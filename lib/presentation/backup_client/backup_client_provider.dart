import 'package:flutter/material.dart';
import 'package:ovavue/presentation/backup_client/backup_client.dart';
import 'package:universal_io/io.dart' as io;

abstract class BackupClientProvider implements BackupClient {
  String get name;

  String displayName(BackupClientLocale locale);

  Future<BackupClientResult> setup(BuildContext context, String accountKey);

  Future<BackupClientResult> import(io.File databaseFile);

  Future<BackupClientResult> export(io.File databaseFile);
}

enum BackupClientLocale {
  en;

  factory BackupClientLocale.from(Locale locale) => switch (locale.languageCode) {
    'en' => en,
    _ => en,
  };
}

enum BackupClientResult {
  success,
  failure,
  dismissed,
  unavailable,
}
