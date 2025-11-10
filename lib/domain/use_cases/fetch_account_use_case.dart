import 'package:ovavue/domain/entities/account_entity.dart';
import 'package:ovavue/domain/repositories/auth.dart';

class FetchAccountUseCase {
  const FetchAccountUseCase({required AuthRepository auth}) : _auth = auth;

  final AuthRepository _auth;

  Future<AccountEntity> call() => _auth.fetch();
}
