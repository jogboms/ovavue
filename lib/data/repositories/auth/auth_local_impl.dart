import 'dart:async';

import 'package:ovavue/data/local_database.dart';
import 'package:ovavue/domain.dart';

class AuthLocalImpl implements AuthRepository {
  const AuthLocalImpl(this._db, this._storage);

  final Database _db;
  final AuthIdentityStorage _storage;

  @override
  Future<AccountEntity> fetch() async {
    final id = await _storage.get();
    final account = await _db.accountsDao.getOrCreateSingleAccount(id);
    if (id == null || id != account.id) {
      await _storage.set(account.id);
    }
    return account;
  }
}

abstract class AuthIdentityStorage {
  FutureOr<String?> get();

  FutureOr<void> set(String id);
}
