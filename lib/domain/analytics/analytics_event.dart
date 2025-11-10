import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AnalyticsEvent with EquatableMixin {
  @visibleForTesting
  factory AnalyticsEvent(String name, [Map<String, Object>? parameters]) = AnalyticsEvent._;

  const AnalyticsEvent._(String name, [this.parameters]) : name = '${_eventNamePrefix}_$name';

  factory AnalyticsEvent.createUser(String userId) =>
      AnalyticsEvent._('create_user', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.createBudget(String userId) =>
      AnalyticsEvent._('create_budget', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.createBudgetCategory(String userId) =>
      AnalyticsEvent._('create_budget_category', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.createBudgetPlan(String userId) =>
      AnalyticsEvent._('create_budget_plan', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.createBudgetMetadata(String userId) =>
      AnalyticsEvent._('create_budget_metadata', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.createBudgetAllocation(String userId) =>
      AnalyticsEvent._('create_budget_allocation', <String, Object>{'user_id': userId});

  factory AnalyticsEvent.activateBudget(String path) =>
      AnalyticsEvent._('activate_budget', <String, Object>{'path': path});

  factory AnalyticsEvent.updateBudget(String path) => AnalyticsEvent._('update_budget', <String, Object>{'path': path});

  factory AnalyticsEvent.updateBudgetCategory(String path) =>
      AnalyticsEvent._('update_budget_category', <String, Object>{'path': path});

  factory AnalyticsEvent.updateBudgetPlan(String path) =>
      AnalyticsEvent._('update_budget_plan', <String, Object>{'path': path});

  factory AnalyticsEvent.updateBudgetMetadata(String path) =>
      AnalyticsEvent._('update_budget_metadata', <String, Object>{'path': path});

  factory AnalyticsEvent.updateBudgetAllocation(String path) =>
      AnalyticsEvent._('update_budget_allocation', <String, Object>{'path': path});

  factory AnalyticsEvent.deleteBudget(String path) => AnalyticsEvent._('delete_budget', <String, Object>{'path': path});

  factory AnalyticsEvent.deleteBudgetPlan(String path) =>
      AnalyticsEvent._('delete_budget_plan', <String, Object>{'path': path});

  factory AnalyticsEvent.deleteBudgetCategory(String path) =>
      AnalyticsEvent._('delete_budget_category', <String, Object>{'path': path});

  factory AnalyticsEvent.deleteBudgetAllocation(String path) =>
      AnalyticsEvent._('delete_budget_allocation', <String, Object>{'path': path});

  factory AnalyticsEvent.addMetadataToPlan(String path) =>
      AnalyticsEvent._('add_metadata_to_plan', <String, Object>{'path': path});

  factory AnalyticsEvent.removeMetadataFromPlan(String path) =>
      AnalyticsEvent._('remove_metadata_from_plan', <String, Object>{'path': path});

  static const _eventNamePrefix = 'app';

  final String name;
  final Map<String, Object>? parameters;

  @override
  List<Object?> get props => <Object?>[name, parameters];

  @override
  String toString() => name + (parameters?.isNotEmpty == true ? ': $parameters' : '');
}
