import 'dart:async';

import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';

class SignOutUseCase {
  const SignOutUseCase({
    required Analytics analytics,
  }) : _analytics = analytics;

  final Analytics _analytics;

  Future<void> call() async {
    unawaited(_analytics.log(AnalyticsEvent.logout));
    unawaited(_analytics.removeUserId());

    throw UnimplementedError();
  }
}
