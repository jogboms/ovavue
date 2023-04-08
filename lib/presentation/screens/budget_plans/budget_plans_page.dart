import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class BudgetPlansPage extends StatefulWidget {
  const BudgetPlansPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BudgetPlansPage(),
      settings: const RouteSettings(name: AppRoutes.budgetPlans),
    );
  }

  @override
  State<BudgetPlansPage> createState() => _BudgetPlansPageState();
}

class _BudgetPlansPageState extends State<BudgetPlansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}
