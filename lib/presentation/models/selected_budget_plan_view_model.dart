import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

import 'budget_allocation_view_model.dart';
import 'selected_budget_category_view_model.dart';

class SelectedBudgetPlanViewModel with EquatableMixin {
  const SelectedBudgetPlanViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.allocation,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final BudgetAllocationViewModel? allocation;
  final String description;
  final SelectedBudgetCategoryViewModel category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, category, createdAt, updatedAt];
}

extension BudgetPlanEntityViewModelExtension on BudgetPlanEntity {
  SelectedBudgetPlanViewModel toViewModel({
    required BudgetAllocationViewModel? allocation,
    required SelectedBudgetCategoryViewModel category,
  }) {
    return SelectedBudgetPlanViewModel(
      id: id,
      path: path,
      title: title,
      allocation: allocation,
      description: description,
      category: category,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
