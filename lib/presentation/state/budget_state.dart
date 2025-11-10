import 'package:equatable/equatable.dart';

import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/utils.dart';

sealed class BaseBudgetState {
  static const BaseBudgetState empty = EmptyBudgetState();
}

class BudgetState with EquatableMixin implements BaseBudgetState {
  const BudgetState({
    required this.budget,
    required this.plans,
    required this.allocation,
    required this.categories,
  });

  final BudgetViewModel budget;
  final List<BudgetPlanViewModel> plans;
  final Money allocation;
  final List<SelectedBudgetCategoryViewModel> categories;

  @override
  List<Object> get props => <Object>[budget, plans, allocation, categories];
}

class EmptyBudgetState implements BaseBudgetState {
  const EmptyBudgetState();
}
