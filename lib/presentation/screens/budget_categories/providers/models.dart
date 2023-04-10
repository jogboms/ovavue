part of 'selected_budget_category_provider.dart';

class BudgetCategoryPlanViewModel with EquatableMixin {
  const BudgetCategoryPlanViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.allocation,
  });

  final String id;
  final String path;
  final String title;
  final Money? allocation;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation];
}

class BudgetCategoryBudgetViewModel with EquatableMixin {
  const BudgetCategoryBudgetViewModel({
    required this.id,
    required this.path,
    required this.amount,
  });

  final String id;
  final String path;
  final Money amount;

  @override
  List<Object?> get props => <Object?>[id, path, amount];
}
