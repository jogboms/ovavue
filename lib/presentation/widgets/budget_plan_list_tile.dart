import 'package:flutter/material.dart';

import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets/budget_category_avatar.dart';

class BudgetPlanListTile extends StatelessWidget {
  const BudgetPlanListTile({
    super.key,
    required this.plan,
    required this.onTap,
    this.trailing,
  });

  final BudgetPlanViewModel plan;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(plan.title.sentence(), maxLines: 1),
      titleTextStyle: theme.textTheme.bodyLarge,
      subtitle: Text(plan.description.capitalize(), maxLines: 2),
      subtitleTextStyle: theme.textTheme.bodyMedium,
      leading: BudgetCategoryAvatar(
        colorScheme: plan.category.colorScheme,
        icon: plan.category.icon.data,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
