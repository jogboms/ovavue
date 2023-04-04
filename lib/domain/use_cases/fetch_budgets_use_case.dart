import '../entities/budget_entity.dart';
import '../repositories/budgets.dart';

class FetchBudgetsUseCase {
  const FetchBudgetsUseCase({
    required BudgetsRepository budgets,
  }) : _budgets = budgets;

  final BudgetsRepository _budgets;

  Stream<NormalizedBudgetEntityList> call(String userId) {
    throw UnimplementedError();
  }
}
