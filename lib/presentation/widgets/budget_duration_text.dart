import 'package:flutter/material.dart';

import '../utils.dart';

enum BudgetDurationTextType { small, medium, large }

class BudgetDurationText extends StatelessWidget {
  const BudgetDurationText({
    super.key,
    required this.startedAt,
    required this.endedAt,
  }) : type = BudgetDurationTextType.small;

  const BudgetDurationText.medium({
    super.key,
    required this.startedAt,
    required this.endedAt,
  }) : type = BudgetDurationTextType.medium;

  const BudgetDurationText.large({
    super.key,
    required this.startedAt,
    required this.endedAt,
  }) : type = BudgetDurationTextType.large;

  final DateTime startedAt;
  final DateTime? endedAt;
  final BudgetDurationTextType type;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final DateTime? endedAt = this.endedAt;
    final TextStyle? textStyle;
    switch (type) {
      case BudgetDurationTextType.small:
        textStyle = textTheme.bodySmall;
        break;
      case BudgetDurationTextType.medium:
        textStyle = textTheme.titleSmall;
        break;
      case BudgetDurationTextType.large:
        textStyle = textTheme.titleMedium;
        break;
    }

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: startedAt.format(DateTimeFormat.dottedInt)),
          if (endedAt != null) ...<TextSpan>[
            const TextSpan(text: ' — '),
            TextSpan(text: endedAt.format(DateTimeFormat.dottedInt)),
          ]
        ],
      ),
      style: textStyle?.copyWith(wordSpacing: 4, color: colorScheme.outline),
    );
  }
}
