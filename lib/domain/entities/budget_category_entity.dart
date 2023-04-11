import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class BudgetCategoryEntity with EquatableMixin {
  const BudgetCategoryEntity({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final int icon;
  final int color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, icon, color, createdAt, updatedAt];

  @override
  bool? get stringify => true;
}

extension BudgetCategoryReferenceEntityExtension on BudgetCategoryEntity {
  ReferenceEntity get reference => ReferenceEntity(id: id, path: path);
}

typedef BudgetCategoryEntityList = List<BudgetCategoryEntity>;
