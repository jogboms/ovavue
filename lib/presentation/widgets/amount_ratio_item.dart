import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils.dart';

class AmountRatioItem extends StatelessWidget {
  const AmountRatioItem({
    super.key,
    required this.allocationAmount,
    required this.budgetAmount,
  }) : isLarge = false;

  const AmountRatioItem.large({
    super.key,
    required this.allocationAmount,
    required this.budgetAmount,
  }) : isLarge = true;

  final Money allocationAmount;
  final Money budgetAmount;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$allocationAmount',
          style: (isLarge ? textTheme.headlineSmall : textTheme.titleMedium)?.copyWith(
            fontWeight: AppFontWeight.bold,
          ),
        ),
        SizedBox(height: isLarge ? 2 : 0),
        Text(
          allocationAmount.percentage(budgetAmount),
          style: (isLarge ? textTheme.titleLarge : textTheme.titleMedium)?.copyWith(
            fontWeight: AppFontWeight.semibold,
            color: colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
