import '../entities/update_user_data.dart';
import '../repositories/users.dart';

class UpdateUserUseCase {
  const UpdateUserUseCase({required UsersRepository users}) : _users = users;

  final UsersRepository _users;

  Future<bool> call(UpdateUserData user) => _users.update(user);
}
