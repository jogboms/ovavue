import 'dart:async';

import 'package:ovavue/core.dart';
import 'package:rxdart/transformers.dart';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/account_entity.dart';
import '../entities/auth_exception.dart';
import '../repositories/auth.dart';

class SignInUseCase {
  const SignInUseCase({
    required AuthRepository auth,
    required Analytics analytics,
  })  : _auth = auth,
        _analytics = analytics;

  final AuthRepository _auth;
  final Analytics _analytics;

  Future<AccountEntity> call() async {
    final Completer<AccountEntity> completer = Completer<AccountEntity>();

    late StreamSubscription<void> sub;
    sub = _auth.onAuthStateChanged.whereNotNull().listen(
      (_) {
        completer.complete(_auth.fetch());
        sub.cancel();
      },
      onError: (Object error, StackTrace stackTrace) {
        completer.completeError(error, stackTrace);
        sub.cancel();
      },
    );

    try {
      await _auth.signIn();
    } on AuthException catch (error, stackTrace) {
      if (error is AuthExceptionTooManyRequests) {
        unawaited(_analytics.log(AnalyticsEvent.tooManyRequests(error.email)));
      } else if (error is AuthExceptionUserDisabled) {
        unawaited(_analytics.log(AnalyticsEvent.userDisabled(error.email)));
      } else if (error is AuthExceptionFailed) {
        AppLog.e(error, stackTrace);
      }
      rethrow;
    }

    return completer.future.then((AccountEntity account) {
      unawaited(_analytics.setUserId(account.id));
      unawaited(_analytics.log(AnalyticsEvent.login(account.email, account.id)));

      return account;
    });
  }
}
