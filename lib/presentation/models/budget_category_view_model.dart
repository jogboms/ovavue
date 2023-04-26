import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';

class BudgetCategoryViewModel with EquatableMixin {
  const BudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.icon,
    required this.colorScheme,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetCategoryViewModel fromEntity(BudgetCategoryEntity entity) {
    return BudgetCategoryViewModel(
      id: entity.id,
      path: entity.path,
      title: entity.title,
      description: entity.description,
      icon: BudgetCategoryIcon.values[entity.iconIndex],
      colorScheme: BudgetCategoryColorScheme.values[entity.colorSchemeIndex],
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final String description;
  final BudgetCategoryIcon icon;
  final BudgetCategoryColorScheme colorScheme;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, icon, colorScheme, createdAt, updatedAt];
}
