import 'package:ovavue/domain/entities/budget_entity.dart';
import 'package:ovavue/domain/repositories/budgets.dart';

class FetchBudgetsUseCase {
  const FetchBudgetsUseCase({
    required BudgetsRepository budgets,
  }) : _budgets = budgets;

  final BudgetsRepository _budgets;

  Stream<BudgetEntityList> call(String userId) => _budgets.fetchAll(userId);
}
