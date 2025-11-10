import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/account_entity.dart';
import 'package:ovavue/domain/entities/user_entity.dart';
import 'package:ovavue/domain/repositories/users.dart';

class CreateUserUseCase {
  const CreateUserUseCase({
    required UsersRepository users,
    required Analytics analytics,
  }) : _users = users,
       _analytics = analytics;

  final UsersRepository _users;
  final Analytics _analytics;

  Future<UserEntity> call(AccountEntity account) {
    _analytics.log(AnalyticsEvent.createUser(account.id)).ignore();
    return _users.create(account);
  }
}
