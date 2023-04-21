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
  final NormalizedBudgetPlanEntityList plans = BudgetPlansMockImpl().seed(
    5,
    (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId, category: categories.random()),
  );
  final int plansLastIndex = plans.length - 1;
  final NormalizedBudgetEntityList budgets = BudgetsMockImpl().seed(
    15,
    (_) {
      final int selectedPlansStartIndex = random.nextInt(plansLastIndex);
      final int selectedPlansLength = random.nextInt(plansLastIndex);
      final List<BaseBudgetPlanEntity<BudgetCategoryEntity>> selectedPlans = plans.sublist(
        selectedPlansStartIndex,
        min(plansLastIndex, selectedPlansStartIndex + selectedPlansLength),
      );
      if (selectedPlans.isEmpty) {
        return plans.sublist(0, 1);
      }
      return selectedPlans;
    },
    userId: userId,
  );
  final Map<String, NormalizedBudgetEntity> budgetById = budgets.foldToMap((_) => _.id);
  final Map<String, int> budgetToAmount = budgetById.map(
    (String key, NormalizedBudgetEntity value) => MapEntry<String, int>(key, value.amount),
  );

  final List<NormalizedBudgetAllocationEntity> allocations = <NormalizedBudgetAllocationEntity>[];
  final int preferredAllocationCount = budgets.length * plans.length;
  for (int i = 0; i < preferredAllocationCount; i++) {
    final String budgetId = budgetById.keys.random();
    final NormalizedBudgetPlanEntity plan = budgetById[budgetId]!.plans.random();

    final int budget = budgetToAmount[budgetId] ?? 0;
    final int amount = random.nextInt(max(1, (budget * random.nextDouble()).toInt()));

    if (random.nextBool()) {
      continue;
    }

    budgetToAmount[budgetId] = max(0, budget - amount);

    allocations.add(
      BudgetAllocationsMockImpl.generateNormalizedAllocation(
        userId: userId,
        amount: amount,
        budget: budgetById[budgetId],
        plan: plan,
      ),
    );
  }

  BudgetAllocationsMockImpl().seed(allocations.length, (int index) => allocations[index]);
}
