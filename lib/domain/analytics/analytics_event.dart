import 'package:meta/meta.dart';

class AnalyticsEvent {
  @visibleForTesting
  factory AnalyticsEvent(String name, [Map<String, dynamic>? parameters]) = AnalyticsEvent._;

  const AnalyticsEvent._(String name, [this.parameters]) : name = '${_eventNamePrefix}_$name';

  static AnalyticsEvent login(String email, String uid) =>
      AnalyticsEvent._('login', <String, dynamic>{'email': email, 'user_id': uid});

  static const AnalyticsEvent logout = AnalyticsEvent._('logout');

  static AnalyticsEvent tooManyRequests(String? email) =>
      AnalyticsEvent._('too_many_requests', <String, dynamic>{'email': email});

  static AnalyticsEvent userDisabled(String? email) =>
      AnalyticsEvent._('user_disabled', <String, dynamic>{'email': email});

  static AnalyticsEvent createUser(String userId) =>
      AnalyticsEvent._('create_user', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudget(String userId) =>
      AnalyticsEvent._('create_budget', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetCategory(String userId) =>
      AnalyticsEvent._('create_budget_category', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetItem(String userId) =>
      AnalyticsEvent._('create_budget_item', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetAllocation(String userId) =>
      AnalyticsEvent._('create_budget_allocation', <String, dynamic>{'user_id': userId});

  static const String _eventNamePrefix = 'app';

  final String name;
  final Map<String, dynamic>? parameters;

  @override
  String toString() => name + (parameters?.isNotEmpty == true ? ': ${parameters?.toString()}' : '');
}
