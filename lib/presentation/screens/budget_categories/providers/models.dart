import 'package:equatable/equatable.dart';

import '../../../models.dart';
import '../../../utils.dart';

class BudgetCategoryPlanViewModel with EquatableMixin {
  const BudgetCategoryPlanViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.allocation,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final Money? allocation;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, allocation];
}

extension BudgetCategoryPlanViewModelExtension on BudgetPlanViewModel {
  BudgetCategoryPlanViewModel toViewModel(Money? allocation) {
    return BudgetCategoryPlanViewModel(
      id: id,
      path: path,
      title: title,
      description: description,
      allocation: allocation,
    );
  }
}
