import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  const BudgetCategoryDetailPage({super.key, required this.id, required this.budgetId});

  final String id;
  final String budgetId;

  static PageRoute<void> route({required String id, required String budgetId}) {
    return MaterialPageRoute<void>(
      builder: (_) => BudgetCategoryDetailPage(id: id, budgetId: budgetId),
      settings: const RouteSettings(name: AppRoutes.budgetCategoryDetail),
    );
  }

  @override
  State<BudgetCategoryDetailPage> createState() => _BudgetCategoryDetailPageState();
}

class _BudgetCategoryDetailPageState extends State<BudgetCategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
