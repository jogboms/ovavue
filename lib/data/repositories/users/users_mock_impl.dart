import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/domain.dart';

import '../auth/auth_mock_impl.dart';

class UsersMockImpl implements UsersRepository {
  static final UserEntity user = UserEntity(
    id: AuthMockImpl.id,
    path: '/users/${AuthMockImpl.id}',
    email: faker.internet.disposableEmail(),
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    lastSeenAt: clock.ago(days: 1),
    createdAt: clock.now(),
  );

  @override
  Future<String> create(AccountEntity account) async => user.id;

  @override
  Future<bool> update(UpdateUserData user) async => true;

  @override
  Future<UserEntity?> fetch(String uid) async => user;
}
