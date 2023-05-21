import 'package:flutter/material.dart';

import '../screens/budget_categories/budget_categories_page.dart';
import '../screens/budget_categories/budget_category_detail_for_budget_page.dart';
import '../screens/budget_categories/budget_category_detail_page.dart';
import '../screens/budget_metadata/budget_metadata_page.dart';
import '../screens/budget_plans/budget_plan_detail_page.dart';
import '../screens/budget_plans/budget_plans_page.dart';
import '../screens/budgets/budget_detail_page.dart';
import '../screens/budgets/budgets_page.dart';
import '../screens/budgets/grouped_budget_plans_page.dart';
import '../screens/preferences/preferences_page.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter(this._context);

  final BuildContext _context;

  Future<void> goToBudgets() => _goTo((_) => const BudgetsPage(), AppRoutes.budgets);

  Future<void> goToBudgetDetail({required String id}) => _goTo((_) => BudgetDetailPage(id: id), AppRoutes.budgetDetail);

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

  Future<void> goToBudgetMetadata() => _goTo((_) => const BudgetMetadataPage(), AppRoutes.metadata);

  Future<void> goToPreferences() => _goTo((_) => const PreferencesPage(), AppRoutes.preferences);

  Future<T?> _goTo<T>(WidgetBuilder builder, String name) => Navigator.of(_context).push<T>(
        MaterialPageRoute<T>(
          builder: (_) => builder(_),
          settings: RouteSettings(name: name),
        ),
      );
}
