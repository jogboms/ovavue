import 'package:ovavue/domain/entities/account_entity.dart';

abstract class AuthRepository {
  Future<AccountEntity> fetch();
}
