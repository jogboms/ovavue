import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'budget_plan_entity.dart';
import 'reference_entity.dart';

@visibleForTesting
class BaseBudgetEntity<T> with EquatableMixin {
  const BaseBudgetEntity({
    required this.id,
    required this.path,
    required this.index,
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
  final int index;
  final String title;
  final int amount;
  final String description;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, index, title, amount, description, startedAt, endedAt, createdAt, updatedAt];
}

typedef BudgetReferenceEntity = BaseBudgetEntity<ReferenceEntity>;
typedef BudgetEntity = BaseBudgetEntity<BudgetPlanEntity>;

typedef BudgetEntityReferenceList = List<BudgetReferenceEntity>;
typedef BudgetEntityList = List<BudgetEntity>;

extension BudgetEntityExtension<T> on BaseBudgetEntity<T> {
  ReferenceEntity get reference => ReferenceEntity(id: id, path: path);
}
