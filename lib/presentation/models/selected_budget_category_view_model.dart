import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models/budget_category_view_model.dart';
import 'package:ovavue/presentation/utils.dart';

typedef SelectedBudgetCategoryViewModel = (BudgetCategoryViewModel, Money);

extension BudgetCategoryEntityViewModelExtension on BudgetCategoryEntity {
  SelectedBudgetCategoryViewModel toViewModel(Money allocation) =>
      (BudgetCategoryViewModel.fromEntity(this), allocation);
}
