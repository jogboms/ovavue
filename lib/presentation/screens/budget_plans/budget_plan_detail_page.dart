import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class BudgetPlanDetailPage extends StatefulWidget {
  const BudgetPlanDetailPage({super.key, required this.id});

  final String id;

  static PageRoute<void> route({required String id}) {
    return MaterialPageRoute<void>(
      builder: (_) => BudgetPlanDetailPage(id: id),
      settings: const RouteSettings(name: AppRoutes.budgetPlanDetail),
    );
  }

  @override
  State<BudgetPlanDetailPage> createState() => _BudgetPlanDetailPageState();
}

class _BudgetPlanDetailPageState extends State<BudgetPlanDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
