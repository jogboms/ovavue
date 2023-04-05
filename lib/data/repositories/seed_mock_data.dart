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
    25,
    (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId, category: categories.random()),
  );
  final NormalizedBudgetEntityList budgets = BudgetsMockImpl().seed(5, userId: userId, plans: plans);
  BudgetAllocationsMockImpl().seed(
    2500,
    (_) {
      final NormalizedBudgetPlanEntity plan = plans.random();
      return BudgetAllocationsMockImpl.generateNormalizedAllocation(
        userId: userId,
        budget: budgets.where((NormalizedBudgetEntity element) => element.plans.contains(plan)).random(),
        plan: plan,
      );
    },
  );
}
