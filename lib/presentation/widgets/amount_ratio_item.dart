import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils.dart';

class AmountRatioItem extends StatelessWidget {
  const AmountRatioItem({
    super.key,
    required this.allocationAmount,
    required this.baseAmount,
    this.foregroundColor,
  }) : isLarge = false;

  const AmountRatioItem.large({
    super.key,
    required this.allocationAmount,
    required this.baseAmount,
    this.foregroundColor,
  }) : isLarge = true;

  final Money allocationAmount;
  final Money baseAmount;
  final Color? foregroundColor;
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
            color: foregroundColor,
          ),
        ),
        SizedBox(height: isLarge ? 2 : 0),
        Text(
          allocationAmount.percentage(baseAmount),
          style: (isLarge ? textTheme.titleLarge : textTheme.titleMedium)?.copyWith(
            fontWeight: AppFontWeight.semibold,
            color: Color.lerp(foregroundColor ?? colorScheme.onBackground, colorScheme.outline, .15),
          ),
        ),
      ],
    );
  }
}
