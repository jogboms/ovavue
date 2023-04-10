import 'package:equatable/equatable.dart';

import 'budget_entity.dart';
import 'budget_plan_entity.dart';
import 'reference_entity.dart';

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

  @override
  bool? get stringify => true;
}

typedef BudgetAllocationEntity = BaseBudgetAllocationEntity<ReferenceEntity, ReferenceEntity>;
typedef NormalizedBudgetAllocationEntity
    = BaseBudgetAllocationEntity<NormalizedBudgetEntity, NormalizedBudgetPlanEntity>;

typedef BudgetAllocationEntityList = List<BudgetAllocationEntity>;
typedef NormalizedBudgetAllocationEntityList = List<NormalizedBudgetAllocationEntity>;

extension NormalizeBudgetAllocationEntityListExtension on BudgetAllocationEntityList {
  NormalizedBudgetAllocationEntityList normalize(NormalizedBudgetEntity budget) =>
      map((BudgetAllocationEntity allocation) => allocation.normalize(budget)).toList(growable: false);

  NormalizedBudgetAllocationEntityList normalizeToMany(Map<String, NormalizedBudgetEntity> budgetIdToBudgets) =>
      map((BudgetAllocationEntity allocation) => allocation.normalize(budgetIdToBudgets[allocation.budget.id]!))
          .toList(growable: false);
}

extension NormalizeBudgetAllocationEntityExtension on BudgetAllocationEntity {
  NormalizedBudgetAllocationEntity normalize(NormalizedBudgetEntity budget) => NormalizedBudgetAllocationEntity(
        id: id,
        path: path,
        amount: amount,
        budget: budget,
        plan: budget.plans.firstWhere((NormalizedBudgetPlanEntity plan) => this.plan.id == plan.id),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
