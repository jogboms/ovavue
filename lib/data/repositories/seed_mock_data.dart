import 'dart:math';

import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';

import 'auth/auth_mock_impl.dart';
import 'budget_allocations/budget_allocations_mock_impl.dart';
import 'budget_categories/budget_categories_mock_impl.dart';
import 'budget_plans/budget_plans_mock_impl.dart';
import 'budgets/budgets_mock_impl.dart';
import 'extensions.dart';

void seedMockData() {
  final String userId = AuthMockImpl.id;
  final BudgetCategoryEntityList categories = BudgetCategoriesMockImpl().seed(10, userId: userId);
  final NormalizedBudgetPlanEntityList plans = BudgetPlansMockImpl().seed(
    10,
    (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId, category: categories.random()),
  );
  final NormalizedBudgetEntityList budgets = BudgetsMockImpl().seed(15, userId: userId, plans: plans);
  final Map<String, NormalizedBudgetEntity> budgetById = budgets.foldToMap((_) => _.id);
  final Map<String, int> budgetToAmount = budgetById.map(
    (String key, NormalizedBudgetEntity value) => MapEntry<String, int>(key, value.amount),
  );
  BudgetAllocationsMockImpl().seed(
    budgets.length * plans.length * 10,
    (_) {
      final NormalizedBudgetPlanEntity plan = plans.random();
      final String budgetId = budgetById.keys.random();

      final int budget = budgetToAmount[budgetId] ?? 0;
      final int amount = Random().nextInt(budget ~/ 2);

      budgetToAmount[budgetId] = budget - amount;

      return BudgetAllocationsMockImpl.generateNormalizedAllocation(
        userId: userId,
        amount: amount,
        budget: budgetById[budgetId],
        plan: plan,
      );
    },
  );
}
