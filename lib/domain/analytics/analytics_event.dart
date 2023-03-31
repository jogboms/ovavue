import 'package:meta/meta.dart';

class AnalyticsEvent {
  @visibleForTesting
  factory AnalyticsEvent(String name, [Map<String, dynamic>? parameters]) = AnalyticsEvent._;

  const AnalyticsEvent._(String name, [this.parameters]) : name = '${_eventNamePrefix}_$name';

  static AnalyticsEvent login(String email, String uid) =>
      AnalyticsEvent._('login', <String, dynamic>{'email': email, 'user_id': uid});

  static const AnalyticsEvent logout = AnalyticsEvent._('logout');

  static const String _eventNamePrefix = 'app';

  final String name;
  final Map<String, dynamic>? parameters;

  @override
  String toString() => name + (parameters?.isNotEmpty == true ? ': ${parameters?.toString()}' : '');
}
