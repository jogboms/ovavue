import 'dart:async';

import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class AuthLocalImpl implements AuthRepository {
  const AuthLocalImpl(this._db, this._storage);

  final Database _db;
  final AuthIdentityStorage _storage;

  @override
  Future<AccountEntity> fetch() async {
    final String? id = await _storage.get();
    final AccountEntity account = await _db.accountsDao.getOrCreateSingleAccount(id);
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
