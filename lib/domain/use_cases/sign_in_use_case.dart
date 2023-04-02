import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/account_entity.dart';

class SignInUseCase {
  const SignInUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Future<AccountEntity> call() {
    // TODO(Jogboms): remove fake object.
    const AccountEntity account = AccountEntity(id: '1', displayName: 'name', email: 'email');
    unawaited(_analytics.setUserId(account.id));
    unawaited(_analytics.log(AnalyticsEvent.login(account.email, account.id)));

    throw UnimplementedError();
  }
}
