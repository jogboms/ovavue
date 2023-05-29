import 'dart:math';

import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';

import 'auth/auth_mock_impl.dart';
import 'budget_allocations/budget_allocations_mock_impl.dart';
import 'budget_categories/budget_categories_mock_impl.dart';
import 'budget_plans/budget_plans_mock_impl.dart';
import 'budgets/budgets_mock_impl.dart';

void seedMockData() {
  final Random random = Random();
  final String userId = AuthMockImpl.id;
  final BudgetCategoryEntityList categories = BudgetCategoriesMockImpl().seed(10, userId: userId);
  final BudgetPlanEntityList plans = BudgetPlansMockImpl().seed(
    15,
    (_) => BudgetPlansMockImpl.generatePlan(userId: userId, category: categories.random()),
  );
  final BudgetEntityList budgets = BudgetsMockImpl().seed(5, userId: userId);
  final Map<String, BudgetEntity> budgetById = budgets.foldToMap((_) => _.id);
  final Map<String, int> budgetToAmount = budgetById.map(
    (String key, BudgetEntity value) => MapEntry<String, int>(key, value.amount),
  );

  final List<BudgetAllocationEntity> allocations = <BudgetAllocationEntity>[];
  final int preferredAllocationCount = budgets.length * plans.length;
  for (int i = 0; i < preferredAllocationCount; i++) {
    final String budgetId = budgetById.keys.random();
    final BudgetPlanEntity plan = plans.random();

    final int budget = budgetToAmount[budgetId] ?? 0;
    final int amount = random.nextInt(max(1, (budget * random.nextDouble()).toInt()));

    if (random.nextBool()) {
      continue;
    }

    budgetToAmount[budgetId] = max(0, budget - amount);

    allocations.add(
      BudgetAllocationsMockImpl.generateAllocation(
        userId: userId,
        amount: amount,
        budget: budgetById[budgetId],
        plan: plan,
      ),
    );
  }

  BudgetAllocationsMockImpl().seed(allocations.length, (int index) => allocations[index]);
}
