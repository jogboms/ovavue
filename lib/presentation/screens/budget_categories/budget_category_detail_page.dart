import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  const BudgetCategoryDetailPage({super.key, required this.id});

  final String id;

  static PageRoute<void> route({required String id}) {
    return MaterialPageRoute<void>(
      builder: (_) => BudgetCategoryDetailPage(id: id),
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
