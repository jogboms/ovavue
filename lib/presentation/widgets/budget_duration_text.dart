import 'package:flutter/material.dart';

import '../utils.dart';

class BudgetDurationText extends StatelessWidget {
  const BudgetDurationText({
    super.key,
    required this.startedAt,
    required this.endedAt,
  }) : isLarge = false;

  const BudgetDurationText.large({
    super.key,
    required this.startedAt,
    required this.endedAt,
  }) : isLarge = true;

  final DateTime startedAt;
  final DateTime? endedAt;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final DateTime? endedAt = this.endedAt;

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
      style: (isLarge ? textTheme.titleMedium : textTheme.bodySmall)?.copyWith(
        wordSpacing: 8,
        color: colorScheme.outline,
      ),
    );
  }
}
