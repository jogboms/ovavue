import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';
import '../../widgets.dart';

class BudgetCategoryDetailForBudgetPage extends StatefulWidget {
  const BudgetCategoryDetailForBudgetPage({super.key, required this.id, required this.budgetId});

  final String id;
  final String budgetId;

  static PageRoute<void> route({required String id, required String budgetId}) {
    return MaterialPageRoute<void>(
      builder: (_) => BudgetCategoryDetailForBudgetPage(id: id, budgetId: budgetId),
      settings: const RouteSettings(name: AppRoutes.budgetCategoryDetail),
    );
  }

  @override
  State<BudgetCategoryDetailForBudgetPage> createState() => _BudgetCategoryDetailForBudgetPageState();
}

class _BudgetCategoryDetailForBudgetPageState extends State<BudgetCategoryDetailForBudgetPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar.empty,
      body: _ContentDataView(
        key: dataViewKey,
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
