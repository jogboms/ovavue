import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:ovavue/domain/entities/budget_category_entity.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';

@visibleForTesting
class BaseBudgetPlanEntity<T> with EquatableMixin {
  const BaseBudgetPlanEntity({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final T category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, category, createdAt, updatedAt];
}

typedef BudgetPlanReferenceEntity = BaseBudgetPlanEntity<ReferenceEntity>;
typedef BudgetPlanEntity = BaseBudgetPlanEntity<BudgetCategoryEntity>;

typedef BudgetPlanReferenceEntityList = List<BudgetPlanReferenceEntity>;
typedef BudgetPlanEntityList = List<BudgetPlanEntity>;
