import '../entities/account_entity.dart';
import '../entities/update_user_data.dart';
import '../entities/user_entity.dart';

abstract class UsersRepository {
  Future<UserEntity> create(AccountEntity account);

  Future<bool> update(UpdateUserData user);

  Future<UserEntity?> fetch(String uid);
}
