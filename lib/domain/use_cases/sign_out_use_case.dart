import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../repositories/auth.dart';

class SignOutUseCase {
  const SignOutUseCase({
    required AuthRepository auth,
    required Analytics analytics,
  })  : _auth = auth,
        _analytics = analytics;

  final AuthRepository _auth;
  final Analytics _analytics;

  Future<void> call() async {
    final Completer<void> completer = Completer<void>();

    late StreamSubscription<void> sub;
    sub = _auth.onAuthStateChanged.where((String? id) => id == null).listen(
      (_) {
        completer.complete();
        sub.cancel();
      },
      onError: (Object error, StackTrace st) {
        completer.completeError(error, st);
        sub.cancel();
      },
    );

    await _auth.signOut();

    return completer.future.then((_) {
      unawaited(_analytics.log(AnalyticsEvent.logout));
      unawaited(_analytics.removeUserId());
    });
  }
}
