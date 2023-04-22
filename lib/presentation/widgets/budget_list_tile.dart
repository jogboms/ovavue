import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class BudgetListTile extends StatelessWidget {
  const BudgetListTile({
    super.key,
    required this.id,
    required this.title,
    required this.budgetAmount,
    required this.allocationAmount,
    required this.startedAt,
    required this.endedAt,
    this.onTap,
  });

  final String id;
  final String title;
  final Money budgetAmount;
  final Money? allocationAmount;
  final DateTime startedAt;
  final DateTime? endedAt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final bool active = endedAt == null;
    final Money? allocationAmount = this.allocationAmount;

    final Color? foregroundColor = active ? colorScheme.onInverseSurface : null;
    final TextStyle? titleTextStyle = textTheme.titleMedium?.copyWith(color: foregroundColor);

    return ListTile(
      title: Text(title.sentence(), style: titleTextStyle),
      subtitle: active
          ? Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                margin: const EdgeInsets.only(right: 2),
                child: Text(
                  context.l10n.activeLabel,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
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
      selectedTileColor: colorScheme.inverseSurface,
      selectedColor: colorScheme.onInverseSurface,
      onTap: active ? null : onTap,
    );
  }
}
