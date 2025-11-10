import 'package:ovavue/domain/entities/budget_entity.dart';
import 'package:ovavue/domain/repositories/budgets.dart';

class FetchActiveBudgetUseCase {
  const FetchActiveBudgetUseCase({
    required BudgetsRepository budgets,
  }) : _budgets = budgets;

  final BudgetsRepository _budgets;

  Stream<BudgetEntity?> call(String userId) => _budgets.fetchActiveBudget(userId);
}
