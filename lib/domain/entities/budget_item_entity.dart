import 'package:equatable/equatable.dart';

import 'budget_category_entity.dart';
import 'reference_entity.dart';

class BaseBudgetItemEntity<T> with EquatableMixin {
  const BaseBudgetItemEntity({
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

typedef BudgetItemEntity = BaseBudgetItemEntity<ReferenceEntity>;
typedef NormalizedBudgetItemEntity = BaseBudgetItemEntity<BudgetCategoryEntity>;

typedef BudgetItemEntityList = List<BudgetItemEntity>;
typedef NormalizedBudgetItemEntityList = List<NormalizedBudgetItemEntity>;
