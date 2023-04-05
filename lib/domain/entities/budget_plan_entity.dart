import 'package:equatable/equatable.dart';

import 'budget_category_entity.dart';
import 'reference_entity.dart';

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

  @override
  bool? get stringify => true;
}

typedef BudgetPlanEntity = BaseBudgetPlanEntity<ReferenceEntity>;
typedef NormalizedBudgetPlanEntity = BaseBudgetPlanEntity<BudgetCategoryEntity>;

typedef BudgetPlanEntityList = List<BudgetPlanEntity>;
typedef NormalizedBudgetPlanEntityList = List<NormalizedBudgetPlanEntity>;

extension NormalizedBudgetPlanReferenceEntityExtension on NormalizedBudgetPlanEntity {
  ReferenceEntity get reference => ReferenceEntity(id: id, path: path);
}

extension NormalizeBudgetPlanEntityListExtension on BudgetPlanEntityList {
  NormalizedBudgetPlanEntityList normalize(BudgetCategoryEntityList categories) =>
      map((BudgetPlanEntity plan) => plan.normalize(categories)).toList(growable: false);
}

extension NormalizeBudgetPlanEntityExtension on BudgetPlanEntity {
  NormalizedBudgetPlanEntity normalize(BudgetCategoryEntityList categories) => NormalizedBudgetPlanEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        category: categories.firstWhere((BudgetCategoryEntity category) => category.id == category.id),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
