import 'package:flutter/material.dart';

import '../screens/active_budget/grouped_budget_plans_page.dart';
import '../screens/budget_categories/budget_categories_page.dart';
import '../screens/budget_categories/budget_category_detail_for_budget_page.dart';
import '../screens/budget_categories/budget_category_detail_page.dart';
import '../screens/budget_plans/budget_plan_detail_page.dart';
import '../screens/budget_plans/budget_plans_page.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter(this._context);

  final BuildContext _context;

  Future<void> goToBudgetCategories() => _goTo((_) => const BudgetCategoriesPage(), AppRoutes.budgetCategories);

  Future<void> goToBudgetCategoryDetailForBudget({required String id, required String budgetId}) => _goTo(
        (_) => BudgetCategoryDetailForBudgetPage(id: id, budgetId: budgetId),
        AppRoutes.budgetCategoryDetail,
      );

  Future<void> goToBudgetCategoryDetail({required String id}) => _goTo(
        (_) => BudgetCategoryDetailPage(id: id),
        AppRoutes.budgetCategoryDetail,
      );

  Future<void> goToBudgetPlanDetail({required String id, String? budgetId}) => _goTo(
        (_) => BudgetPlanDetailPage(id: id, budgetId: budgetId),
        AppRoutes.budgetPlanDetail,
      );

  Future<void> goToBudgetPlans() => _goTo((_) => const BudgetPlansPage(), AppRoutes.budgetPlans);

  Future<void> goToGroupedBudgetPlans({required String budgetId}) => _goTo(
        (_) => GroupedBudgetPlansPage(budgetId: budgetId),
        AppRoutes.groupedBudgetPlans,
      );

  Future<T?> _goTo<T>(WidgetBuilder builder, String name) => Navigator.of(_context).push<T>(
        MaterialPageRoute<T>(
          builder: (_) => builder(_),
          settings: RouteSettings(name: name),
        ),
      );
}
