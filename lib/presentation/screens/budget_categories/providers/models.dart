import '../../../models.dart';
import '../../../utils.dart';

typedef BudgetCategoryPlanViewModel = (BudgetPlanViewModel, Money?);

extension BudgetCategoryPlanViewModelExtension on BudgetPlanViewModel {
  BudgetCategoryPlanViewModel toViewModel(Money? allocation) => (this, allocation);
}
