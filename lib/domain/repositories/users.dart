import '../entities/account_entity.dart';
import '../entities/user_entity.dart';

abstract class UsersRepository {
  Future<UserEntity> create(AccountEntity account);

  Future<UserEntity?> fetch(String uid);
}
