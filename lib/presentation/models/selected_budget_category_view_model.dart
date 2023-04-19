import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';
import 'budget_category_view_model.dart';

class SelectedBudgetCategoryViewModel with EquatableMixin {
  const SelectedBudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.allocation,
    required this.description,
    required this.icon,
    required this.brightness,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money allocation;
  final String description;
  final IconData icon;
  final Brightness brightness;
  final Color foregroundColor;
  final Color backgroundColor;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        path,
        title,
        allocation,
        description,
        icon,
        brightness,
        foregroundColor,
        backgroundColor,
        createdAt,
        updatedAt
      ];
}

extension BudgetCategoryEntityViewModelExtension on BudgetCategoryEntity {
  SelectedBudgetCategoryViewModel toViewModel(Money allocation) {
    final BudgetCategoryViewModel category = BudgetCategoryViewModel.fromEntity(this);
    return SelectedBudgetCategoryViewModel(
      id: category.id,
      path: category.path,
      title: category.title,
      allocation: allocation,
      description: category.description,
      icon: category.icon,
      brightness: category.brightness,
      foregroundColor: category.foregroundColor,
      backgroundColor: category.backgroundColor,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }
}
