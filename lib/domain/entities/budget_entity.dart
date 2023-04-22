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
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, amount, description, startedAt, endedAt, createdAt, updatedAt];

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
  NormalizedBudgetEntityList normalize() => map((BudgetEntity budget) => budget.normalize()).toList(growable: false);
}

extension NormalizeBudgetEntityExtension on BudgetEntity {
  NormalizedBudgetEntity normalize() => NormalizedBudgetEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        amount: amount,
        startedAt: startedAt,
        endedAt: endedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
