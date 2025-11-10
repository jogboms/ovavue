import 'package:equatable/equatable.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/models.dart';
import 'package:ovavue/presentation/utils.dart';

class BudgetCategoryState with EquatableMixin {
  const BudgetCategoryState({
    required this.category,
    required this.allocation,
    required this.budget,
    required this.plans,
  });

  final BudgetCategoryViewModel category;
  final Money? allocation;
  final BudgetViewModel? budget;
  final List<BudgetCategoryPlanViewModel> plans;

  @override
  List<Object?> get props => <Object?>[category, allocation, budget, plans];
}
