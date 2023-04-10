part of 'active_budget_state_provider.dart';

class ActiveBudgetCategoryViewModel with EquatableMixin {
  const ActiveBudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.allocation,
    required this.description,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money allocation;
  final String description;
  final Color color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, color, createdAt, updatedAt];
}

class ActiveBudgetPlanViewModel with EquatableMixin {
  const ActiveBudgetPlanViewModel({
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
  final ActiveBudgetCategoryViewModel category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, category, createdAt, updatedAt];
}

class ActiveBudgetViewModel with EquatableMixin {
  const ActiveBudgetViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.amount,
    required this.allocation,
    required this.description,
    required this.plans,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money amount;
  final Money allocation;
  final String description;
  final List<ActiveBudgetPlanViewModel> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, amount, allocation, description, plans, startedAt, endedAt, createdAt, updatedAt];
}
