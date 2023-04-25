import 'package:equatable/equatable.dart';

import '../../../models.dart';
import '../../../utils.dart';
import 'models.dart';

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
