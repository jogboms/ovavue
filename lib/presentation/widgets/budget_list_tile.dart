import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils.dart';
import '../widgets.dart';

class BudgetListTile extends StatelessWidget {
  const BudgetListTile({
    super.key,
    required this.id,
    required this.title,
    required this.budgetAmount,
    required this.allocationAmount,
    required this.active,
    required this.startedAt,
    required this.endedAt,
    this.onTap,
  });

  final String id;
  final String title;
  final Money budgetAmount;
  final Money? allocationAmount;
  final bool active;
  final DateTime startedAt;
  final DateTime? endedAt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final Money? allocationAmount = this.allocationAmount;

    final Color? foregroundColor = active ? colorScheme.onSurfaceVariant : null;
    final TextStyle? titleTextStyle = textTheme.titleMedium?.copyWith(color: foregroundColor);

    return ListTile(
      title: Text(title.sentence(), style: titleTextStyle),
      subtitle: active
          ? Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.inverseSurface,
                  borderRadius: AppBorderRadius.c4,
                ),
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                margin: const EdgeInsets.only(right: 2),
                child: Text(
                  context.l10n.activeLabel,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onInverseSurface,
                  ),
                ),
              ),
            )
          : BudgetDurationText.medium(startedAt: startedAt, endedAt: endedAt),
      trailing: allocationAmount == null
          ? Text(budgetAmount.formatted, style: titleTextStyle)
          : AmountRatioItem(
              allocationAmount: allocationAmount,
              baseAmount: budgetAmount,
              foregroundColor: foregroundColor,
            ),
      selected: active,
      selectedTileColor: colorScheme.surfaceVariant,
      selectedColor: foregroundColor,
      onTap: active ? null : onTap,
    );
  }
}
