import 'package:ovavue/domain.dart';

import '../utils.dart';
import 'budget_category_view_model.dart';

typedef SelectedBudgetCategoryViewModel = (BudgetCategoryViewModel, Money);

extension BudgetCategoryEntityViewModelExtension on BudgetCategoryEntity {
  SelectedBudgetCategoryViewModel toViewModel(Money allocation) =>
      (BudgetCategoryViewModel.fromEntity(this), allocation);
}
