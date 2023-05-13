import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class UsersLocalImpl implements UsersRepository {
  const UsersLocalImpl(this._db);

  final Database _db;

  @override
  Future<UserEntity> create(AccountEntity account) => _db.usersDao.createUser(account);

  @override
  Future<UserEntity?> fetch(String uid) => _db.usersDao.getSingleUser(uid);
}
