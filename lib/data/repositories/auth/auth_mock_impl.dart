import 'package:faker/faker.dart';
import 'package:ovavue/domain.dart';

class AuthMockImpl extends AuthRepository {
  static final String id = faker.guid.guid();

  static AccountEntity generateAccount() => AccountEntity(id: id);

  @override
  Future<AccountEntity> fetch() async => generateAccount();
}
