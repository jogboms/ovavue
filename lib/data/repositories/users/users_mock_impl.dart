import 'package:clock/clock.dart';
import 'package:ovavue/data/repositories/auth/auth_mock_impl.dart';
import 'package:ovavue/domain.dart';

class UsersMockImpl implements UsersRepository {
  static final user = UserEntity(
    id: AuthMockImpl.id,
    path: '/users/${AuthMockImpl.id}',
    createdAt: clock.now(),
  );

  @override
  Future<UserEntity> create(AccountEntity account) async => user;

  @override
  Future<UserEntity?> fetch(String uid) async => user;
}
