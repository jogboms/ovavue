part of 'selected_budget_plan_provider.dart';

typedef BudgetPlanAllocationViewModel = (BudgetAllocationViewModel, BudgetViewModel);

extension BudgetPlanAllocationViewModelExtension on BudgetAllocationEntity {
  BudgetPlanAllocationViewModel toViewModelPair() => (toViewModel(), BudgetViewModel.fromEntity(budget));
}
