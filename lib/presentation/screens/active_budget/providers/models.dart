part of 'active_budget_provider.dart';

class ActiveBudgetCategoryViewModel with EquatableMixin {
  const ActiveBudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.allocation,
    required this.description,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money allocation;
  final String description;
  final IconData icon;
  final Color color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, icon, color, createdAt, updatedAt];
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
  final String description;
  final List<ActiveBudgetPlanViewModel> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, title, amount, description, plans, startedAt, endedAt, createdAt, updatedAt];
}

extension NormalizedBudgetEntityViewModelExtension on NormalizedBudgetEntity {
  ActiveBudgetViewModel toViewModel(List<ActiveBudgetPlanViewModel> plans) {
    return ActiveBudgetViewModel(
      id: id,
      path: path,
      title: title,
      amount: Money(amount),
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      startedAt: startedAt,
      endedAt: endedAt,
      plans: plans,
    );
  }
}

extension NormalizedBudgetPlanEntityViewModelExtension on NormalizedBudgetPlanEntity {
  ActiveBudgetPlanViewModel toViewModel({
    required BudgetAllocationViewModel? allocation,
    required ActiveBudgetCategoryViewModel category,
  }) {
    return ActiveBudgetPlanViewModel(
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

extension BudgetCategoryEntityViewModelExtension on BudgetCategoryEntity {
  ActiveBudgetCategoryViewModel toViewModel(Money allocation) {
    final BudgetCategoryViewModel category = BudgetCategoryViewModel.fromEntity(this);
    return ActiveBudgetCategoryViewModel(
      id: category.id,
      path: category.path,
      title: category.title,
      allocation: allocation,
      description: category.description,
      icon: category.icon,
      color: category.color,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }
}
