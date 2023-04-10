part of 'selected_budget_plan_provider.dart';

class BudgetPlanAllocationViewModel with EquatableMixin {
  const BudgetPlanAllocationViewModel({
    required this.id,
    required this.path,
    required this.amount,
    required this.budget,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final Money amount;
  final BudgetPlanAllocationBudgetViewModel budget;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, amount, budget, createdAt, updatedAt];
}

class BudgetPlanAllocationBudgetViewModel with EquatableMixin {
  const BudgetPlanAllocationBudgetViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.amount,
    required this.startedAt,
    required this.endedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money amount;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, amount, startedAt, endedAt];
}

extension NormalizedBudgetAllocationViewModelExtension on NormalizedBudgetAllocationEntity {
  BudgetPlanAllocationViewModel toViewModel() => BudgetPlanAllocationViewModel(
        id: id,
        path: path,
        amount: Money(amount),
        createdAt: createdAt,
        updatedAt: updatedAt,
        budget: BudgetPlanAllocationBudgetViewModel(
          id: budget.id,
          path: budget.path,
          title: budget.title,
          amount: Money(budget.amount),
          startedAt: budget.startedAt,
          endedAt: budget.endedAt,
        ),
      );
}
