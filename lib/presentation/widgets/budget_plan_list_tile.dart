import 'package:flutter/material.dart';

import '../models.dart';
import '../utils.dart';

class BudgetPlanListTile extends StatelessWidget {
  const BudgetPlanListTile({super.key, required this.plan, required this.onTap});

  final BudgetPlanViewModel plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(plan.title.sentence(), maxLines: 1),
      titleTextStyle: theme.textTheme.bodyLarge,
      subtitle: Text(plan.description.capitalize(), maxLines: 2),
      subtitleTextStyle: theme.textTheme.bodyMedium,
      leading: CircleAvatar(
        backgroundColor: plan.category.backgroundColor,
        foregroundColor: plan.category.foregroundColor,
        child: Icon(plan.category.icon),
      ),
      onTap: onTap,
    );
  }
}
