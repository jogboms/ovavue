import 'package:equatable/equatable.dart';

import 'budget_allocation_view_model.dart';
import 'budget_category_view_model.dart';

class BudgetPlanViewModel with EquatableMixin {
  const BudgetPlanViewModel({
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
  final BudgetCategoryViewModel category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, category, createdAt, updatedAt];
}
