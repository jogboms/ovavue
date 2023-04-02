import 'dart:async';

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
    unawaited(_analytics.log(AnalyticsEvent.createUser(account.id)));
    return _users.create(account);
  }
}
