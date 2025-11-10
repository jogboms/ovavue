import 'package:flutter/material.dart';

class BudgetMetadataValueVerticalDivider extends StatelessWidget {
  const BudgetMetadataValueVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '=',
        style: textTheme.headlineSmall?.copyWith(color: colorScheme.outline),
      ),
    );
  }
}
