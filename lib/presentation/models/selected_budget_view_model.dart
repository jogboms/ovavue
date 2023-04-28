import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';
import 'selected_budget_plan_view_model.dart';

class SelectedBudgetViewModel with EquatableMixin {
  const SelectedBudgetViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.index,
    required this.amount,
    required this.description,
    required this.plans,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final int index;
  final String title;
  final Money amount;
  final String description;
  final List<SelectedBudgetPlanViewModel> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, index, title, amount, description, plans, startedAt, endedAt, createdAt, updatedAt];
}

extension BudgetEntityViewModelExtension on BudgetEntity {
  SelectedBudgetViewModel toViewModel(List<SelectedBudgetPlanViewModel> plans) {
    return SelectedBudgetViewModel(
      id: id,
      path: path,
      index: index,
      title: title,
      amount: Money(amount),
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      startedAt: startedAt,
      endedAt: endedAt,
      plans: plans,
    );
  }
}
