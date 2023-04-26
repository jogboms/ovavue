import 'package:equatable/equatable.dart';
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
    required this.colorScheme,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money allocation;
  final String description;
  final BudgetCategoryIcon icon;
  final BudgetCategoryColorScheme colorScheme;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, allocation, description, icon, colorScheme, createdAt, updatedAt];
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
      colorScheme: category.colorScheme,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }
}
