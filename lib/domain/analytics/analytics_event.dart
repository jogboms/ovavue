import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AnalyticsEvent with EquatableMixin {
  @visibleForTesting
  factory AnalyticsEvent(String name, [Map<String, dynamic>? parameters]) = AnalyticsEvent._;

  const AnalyticsEvent._(String name, [this.parameters]) : name = '${_eventNamePrefix}_$name';

  static AnalyticsEvent createUser(String userId) =>
      AnalyticsEvent._('create_user', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudget(String userId) =>
      AnalyticsEvent._('create_budget', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetCategory(String userId) =>
      AnalyticsEvent._('create_budget_category', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetPlan(String userId) =>
      AnalyticsEvent._('create_budget_plan', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetMetadata(String userId) =>
      AnalyticsEvent._('create_budget_metadata', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent createBudgetAllocation(String userId) =>
      AnalyticsEvent._('create_budget_allocation', <String, dynamic>{'user_id': userId});

  static AnalyticsEvent activateBudget(String path) =>
      AnalyticsEvent._('activate_budget', <String, dynamic>{'path': path});

  static AnalyticsEvent updateBudget(String path) => AnalyticsEvent._('update_budget', <String, dynamic>{'path': path});

  static AnalyticsEvent updateBudgetCategory(String path) =>
      AnalyticsEvent._('update_budget_category', <String, dynamic>{'path': path});

  static AnalyticsEvent updateBudgetPlan(String path) =>
      AnalyticsEvent._('update_budget_plan', <String, dynamic>{'path': path});

  static AnalyticsEvent updateBudgetMetadata(String path) =>
      AnalyticsEvent._('update_budget_metadata', <String, dynamic>{'path': path});

  static AnalyticsEvent updateBudgetAllocation(String path) =>
      AnalyticsEvent._('update_budget_allocation', <String, dynamic>{'path': path});

  static AnalyticsEvent deleteBudget(String path) => AnalyticsEvent._('delete_budget', <String, dynamic>{'path': path});

  static AnalyticsEvent deleteBudgetPlan(String path) =>
      AnalyticsEvent._('delete_budget_plan', <String, dynamic>{'path': path});

  static AnalyticsEvent deleteBudgetCategory(String path) =>
      AnalyticsEvent._('delete_budget_category', <String, dynamic>{'path': path});

  static AnalyticsEvent deleteBudgetAllocation(String path) =>
      AnalyticsEvent._('delete_budget_allocation', <String, dynamic>{'path': path});

  static AnalyticsEvent addMetadataToPlan(String path) =>
      AnalyticsEvent._('add_metadata_to_plan', <String, dynamic>{'path': path});

  static AnalyticsEvent removeMetadataFromPlan(String path) =>
      AnalyticsEvent._('remove_metadata_from_plan', <String, dynamic>{'path': path});

  static const String _eventNamePrefix = 'app';

  final String name;
  final Map<String, dynamic>? parameters;

  @override
  List<Object?> get props => <Object?>[name, parameters];

  @override
  String toString() => name + (parameters?.isNotEmpty == true ? ': ${parameters?.toString()}' : '');
}
