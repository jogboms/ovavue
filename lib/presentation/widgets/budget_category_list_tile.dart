import 'package:flutter/material.dart';

import '../models.dart';
import '../utils.dart';

class BudgetCategoryListTile extends StatelessWidget {
  const BudgetCategoryListTile({
    super.key,
    required this.category,
    this.onTap,
  });

  final BudgetCategoryViewModel category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(category.title.sentence(), maxLines: 1),
      titleTextStyle: theme.textTheme.bodyLarge,
      subtitle: Text(category.description.capitalize(), maxLines: 2),
      subtitleTextStyle: theme.textTheme.bodyMedium,
      leading: CircleAvatar(
        backgroundColor: category.backgroundColor,
        foregroundColor: category.foregroundColor,
        child: Icon(category.icon),
      ),
      onTap: onTap,
    );
  }
}
