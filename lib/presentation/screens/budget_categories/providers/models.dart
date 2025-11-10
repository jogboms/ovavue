import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/utils.dart';

typedef BudgetCategoryPlanViewModel = (BudgetPlanViewModel, Money?);

extension BudgetCategoryPlanViewModelExtension on BudgetPlanViewModel {
  BudgetCategoryPlanViewModel toViewModel(Money? allocation) => (this, allocation);
}
