import 'package:ovavue/domain/entities/account_entity.dart';
import 'package:ovavue/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<UserEntity> create(AccountEntity account);

  Future<UserEntity?> fetch(String uid);
}
