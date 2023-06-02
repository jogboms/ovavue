import 'package:flutter/material.dart';

class BudgetMetadataValueVerticalDivider extends StatelessWidget {
  const BudgetMetadataValueVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '=',
        style: textTheme.headlineSmall?.copyWith(color: colorScheme.outline),
      ),
    );
  }
}
