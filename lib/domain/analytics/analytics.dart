import 'analytics_event.dart';

abstract class Analytics {
  Future<void> setUserId(String id);

  Future<void> removeUserId();

  Future<void> log(AnalyticsEvent event);

  Future<void> setCurrentScreen(String name);
}
