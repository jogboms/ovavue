import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class BudgetCategoriesPage extends StatefulWidget {
  const BudgetCategoriesPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BudgetCategoriesPage(),
      settings: const RouteSettings(name: AppRoutes.budgetCategories),
    );
  }

  @override
  State<BudgetCategoriesPage> createState() => _BudgetCategoriesPageState();
}

class _BudgetCategoriesPageState extends State<BudgetCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
