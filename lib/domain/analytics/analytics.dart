import 'analytics_event.dart';

abstract class Analytics {
  Future<void> setUserId(String id);

  Future<void> removeUserId();

  Future<void> log(AnalyticsEvent event);

  Future<void> setCurrentScreen(String name);
}

class NoopAnalytics implements Analytics {
  const NoopAnalytics();

  @override
  Future<void> log(AnalyticsEvent event) async {}

  @override
  Future<void> removeUserId() async {}

  @override
  Future<void> setUserId(String id) async {}

  @override
  Future<void> setCurrentScreen(String name) async {}
}
