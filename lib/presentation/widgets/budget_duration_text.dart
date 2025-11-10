import 'package:flutter/material.dart';

import 'package:ovavue/presentation/utils.dart';

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final endedAt = this.endedAt;
    final textStyle = switch (type) {
      BudgetDurationTextType.small => textTheme.bodySmall,
      BudgetDurationTextType.medium => textTheme.titleSmall,
      BudgetDurationTextType.large => textTheme.titleMedium,
    };

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: startedAt.format(DateTimeFormat.dottedInt)),
          if (endedAt != null) ...<TextSpan>[
            const TextSpan(text: ' — '),
            TextSpan(text: endedAt.format(DateTimeFormat.dottedInt)),
          ],
        ],
      ),
      style: textStyle?.copyWith(wordSpacing: 4, color: colorScheme.outline),
    );
  }
}
