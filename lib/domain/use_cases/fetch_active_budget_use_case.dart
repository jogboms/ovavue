import '../entities/budget_entity.dart';
import '../repositories/budgets.dart';

class FetchActiveBudgetUseCase {
  const FetchActiveBudgetUseCase({
    required BudgetsRepository budgets,
  }) : _budgets = budgets;

  final BudgetsRepository _budgets;

  Stream<NormalizedBudgetEntity> call(String userId) {
    throw UnimplementedError();
  }
}
