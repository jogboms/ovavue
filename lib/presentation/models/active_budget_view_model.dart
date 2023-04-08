import 'package:equatable/equatable.dart';

import '../utils.dart';
import 'active_budget_plan_view_model.dart';

class ActiveBudgetViewModel with EquatableMixin {
  const ActiveBudgetViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.amount,
    required this.allocation,
    required this.description,
    required this.plans,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money amount;
  final Money allocation;
  final String description;
  final List<ActiveBudgetPlanViewModel> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, amount, allocation, description, plans, startedAt, endedAt, createdAt, updatedAt];
}
