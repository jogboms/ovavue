import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';
import '../../widgets.dart';

class GroupedBudgetPlansPage extends StatefulWidget {
  const GroupedBudgetPlansPage({super.key, required this.budgetId});

  final String budgetId;

  static PageRoute<void> route({required String budgetId}) {
    return MaterialPageRoute<void>(
      builder: (_) => GroupedBudgetPlansPage(budgetId: budgetId),
      settings: const RouteSettings(name: AppRoutes.groupedBudgetPlans),
    );
  }

  @override
  State<GroupedBudgetPlansPage> createState() => _GroupedBudgetPlansPageState();
}

class _GroupedBudgetPlansPageState extends State<GroupedBudgetPlansPage> {
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
