import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models/budget_allocation_view_model.dart';
import 'package:ovavue/presentation/models/budget_category_view_model.dart';

class BudgetPlanViewModel with EquatableMixin {
  const BudgetPlanViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.description,
    required this.allocation,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BudgetPlanViewModel.fromEntity(BudgetPlanEntity entity, [BudgetAllocationViewModel? allocation]) =>
      BudgetPlanViewModel(
        id: entity.id,
        title: entity.title,
        path: entity.path,
        description: entity.description,
        allocation: allocation,
        category: BudgetCategoryViewModel.fromEntity(entity.category),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  final String id;
  final String path;
  final String title;
  final String description;
  final BudgetAllocationViewModel? allocation;
  final BudgetCategoryViewModel category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, allocation, category, createdAt, updatedAt];
}
