import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';

class BudgetCategoryViewModel with EquatableMixin {
  const BudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.icon,
    required this.brightness,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetCategoryViewModel fromEntity(BudgetCategoryEntity entity) {
    final DynamicColorScheme colorScheme = DynamicColorScheme.fromHex(entity.color);

    return BudgetCategoryViewModel(
      id: entity.id,
      path: entity.path,
      title: entity.title,
      description: entity.description,
      // TODO(Jogboms): Implement icons picker.
      icon: Icons.category_outlined,
      brightness: colorScheme.brightness,
      foregroundColor: colorScheme.foregroundColor,
      backgroundColor: colorScheme.backgroundColor,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final String description;
  final IconData icon;
  final Brightness brightness;
  final Color foregroundColor;
  final Color backgroundColor;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, description, icon, brightness, foregroundColor, backgroundColor, createdAt, updatedAt];
}
