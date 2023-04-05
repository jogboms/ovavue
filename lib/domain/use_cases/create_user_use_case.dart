import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/account_entity.dart';
import '../repositories/users.dart';

class CreateUserUseCase {
  const CreateUserUseCase({
    required UsersRepository users,
    required Analytics analytics,
  })  : _users = users,
        _analytics = analytics;

  final UsersRepository _users;
  final Analytics _analytics;

  Future<String> call(AccountEntity account) {
    _analytics.log(AnalyticsEvent.createUser(account.id)).ignore();
    return _users.create(account);
  }
}
