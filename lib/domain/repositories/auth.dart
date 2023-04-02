import '../entities/account_entity.dart';

abstract class AuthRepository {
  Future<AccountEntity> fetch();

  Future<String> signIn();

  Stream<String?> get onAuthStateChanged;

  Future<void> signOut();
}
