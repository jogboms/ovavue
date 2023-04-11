import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/domain.dart';

class BudgetCategoryViewModel with EquatableMixin {
  const BudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.icon,
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
      icon: Icons.category_outlined, // TODO(Jogboms): Implement icons picker.
      color: Color(entity.color),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, icon, color, createdAt, updatedAt];
}
