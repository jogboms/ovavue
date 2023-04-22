import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';
import 'budget_plan_view_model.dart';

class BudgetViewModel with EquatableMixin {
  const BudgetViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.amount,
    required this.description,
    required this.plans,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetViewModel fromEntity(
    NormalizedBudgetEntity entity,
    List<NormalizedBudgetPlanEntity> plans,
  ) {
    return BudgetViewModel(
      id: entity.id,
      title: entity.title,
      path: entity.path,
      amount: entity.amount.asMoney,
      description: entity.description,
      plans: plans.map(BudgetPlanViewModel.fromEntity).toList(growable: false),
      startedAt: entity.startedAt,
      endedAt: entity.endedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final Money amount;
  final String description;
  final List<BudgetPlanViewModel> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get active => endedAt == null;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, amount, description, plans, startedAt, endedAt, createdAt, updatedAt];
}
