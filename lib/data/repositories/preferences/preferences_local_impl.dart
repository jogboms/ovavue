import 'dart:async';

import 'package:ovavue/domain.dart';

class PreferencesLocalImpl implements PreferencesRepository {
  PreferencesLocalImpl(this._storage);

  final PreferencesStorage _storage;

  @override
  Future<String> fetchDatabaseLocation() async => _storage.getDatabaseLocation();
}

abstract class PreferencesStorage {
  FutureOr<String> getDatabaseLocation();
}
