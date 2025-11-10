import 'package:ovavue/core.dart';

import 'package:ovavue/domain/entities/user_entity.dart';
import 'package:ovavue/domain/repositories/users.dart';

class FetchUserUseCase {
  const FetchUserUseCase({required UsersRepository users}) : _users = users;

  final UsersRepository _users;

  Future<UserEntity?> call(String uid) async {
    try {
      return _users.fetch(uid);
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return null;
    }
  }
}
