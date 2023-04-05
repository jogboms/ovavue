import 'package:equatable/equatable.dart';

import 'budget_plan_entity.dart';
import 'reference_entity.dart';

class BaseBudgetEntity<T> with EquatableMixin {
  const BaseBudgetEntity({
    required this.id,
    required this.path,
    required this.title,
    required this.amount,
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
  final int amount;
  final String description;
  final List<T> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, amount, description, plans, startedAt, endedAt, createdAt, updatedAt];

  @override
  bool? get stringify => true;
}

typedef BudgetEntity = BaseBudgetEntity<ReferenceEntity>;
typedef NormalizedBudgetEntity = BaseBudgetEntity<NormalizedBudgetPlanEntity>;

typedef BudgetEntityList = List<BudgetEntity>;
typedef NormalizedBudgetEntityList = List<NormalizedBudgetEntity>;

extension NormalizedBudgetReferenceEntityExtension on NormalizedBudgetEntity {
  ReferenceEntity get reference => ReferenceEntity(id: id, path: path);
}

extension NormalizeBudgetEntityListExtension on BudgetEntityList {
  NormalizedBudgetEntityList normalize(NormalizedBudgetPlanEntityList plans) =>
      map((BudgetEntity budget) => budget.normalize(plans)).toList(growable: false);
}

extension NormalizeBudgetEntityExtension on BudgetEntity {
  NormalizedBudgetEntity normalize(NormalizedBudgetPlanEntityList plans) => NormalizedBudgetEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        amount: amount,
        startedAt: startedAt,
        endedAt: endedAt,
        plans: plans
            .where((NormalizedBudgetPlanEntity plan) => plans.map((_) => _.id).contains(plan.id))
            .toList(growable: false),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
