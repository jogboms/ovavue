import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:ovavue/domain/entities/budget_entity.dart';
import 'package:ovavue/domain/entities/budget_plan_entity.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';

@visibleForTesting
class BaseBudgetAllocationEntity<U, V> with EquatableMixin {
  const BaseBudgetAllocationEntity({
    required this.id,
    required this.path,
    required this.amount,
    required this.budget,
    required this.plan,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final int amount;
  final U budget;
  final V plan;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, amount, budget, plan, createdAt, updatedAt];
}

typedef BudgetAllocationReferenceEntity = BaseBudgetAllocationEntity<ReferenceEntity, ReferenceEntity>;
typedef BudgetAllocationEntity = BaseBudgetAllocationEntity<BudgetEntity, BudgetPlanEntity>;

typedef BudgetAllocationReferenceEntityList = List<BudgetAllocationReferenceEntity>;
typedef BudgetAllocationEntityList = List<BudgetAllocationEntity>;
