import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

class BudgetCategoryViewModel with EquatableMixin {
  const BudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetCategoryViewModel fromEntity(BudgetCategoryEntity entity) {
    return BudgetCategoryViewModel(
      id: entity.id,
      path: entity.path,
      title: entity.title,
      description: entity.description,
      color: Color(entity.color),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final String description;
  final Color color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, color, createdAt, updatedAt];
}
