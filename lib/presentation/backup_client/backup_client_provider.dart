import 'dart:async' as async;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'backup_client.dart';

abstract class BackupClientProvider implements BackupClient {
  static BackupClientProvider defaultClient = _FileSystemClientProvider();
  static Set<BackupClientProvider> clients = <BackupClientProvider>{
    defaultClient,
    _CloudClientProvider(),
  };

  static BackupClientProvider? from(String name) => clients.firstWhereOrNull((_) => _.name == name);

  String get name;

  String displayName(BackupClientLocale locale);

  Future<bool> setup(BuildContext context, String id);

  Future<bool> import();

  Future<bool> export();
}

enum BackupClientLocale {
  en;

  factory BackupClientLocale.from(Locale locale) {
    return switch (locale.languageCode) {
      'en' => en,
      _ => en,
    };
  }
}

class _FileSystemClientProvider implements BackupClientProvider {
  @override
  String get name => 'fileSystem';

  @override
  String displayName(BackupClientLocale locale) => switch (locale) {
        BackupClientLocale.en => 'File system',
      };

  @override
  async.Future<bool> setup(BuildContext context, String id) async {
    throw UnimplementedError();
  }

  @override
  async.Future<bool> export() {
    throw UnimplementedError();
  }

  @override
  async.Future<bool> import() {
    throw UnimplementedError();
  }
}

class _CloudClientProvider implements BackupClientProvider {
  @override
  String get name => 'cloud';

  @override
  String displayName(BackupClientLocale locale) => switch (locale) {
        BackupClientLocale.en => 'Cloud',
      };

  @override
  async.Future<bool> setup(BuildContext context, String id) {
    throw UnimplementedError();
  }

  @override
  async.Future<bool> export() {
    throw UnimplementedError();
  }

  @override
  async.Future<bool> import() {
    throw UnimplementedError();
  }
}
