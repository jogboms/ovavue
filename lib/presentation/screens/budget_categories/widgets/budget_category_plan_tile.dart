import 'package:flutter/material.dart';

import '../../../models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class BudgetCategoryPlanTile extends StatelessWidget {
  const BudgetCategoryPlanTile({
    super.key,
    required this.plan,
    required this.allocationAmount,
    required this.categoryAllocationAmount,
    required this.onPressed,
  });

  final BudgetPlanViewModel plan;
  final Money? allocationAmount;
  final Money? categoryAllocationAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final Money? allocationAmount = this.allocationAmount;
    final Money? categoryAllocationAmount = this.categoryAllocationAmount;

    return AmountRatioDecoratedBox(
      ratio: allocationAmount != null && categoryAllocationAmount != null
          ? allocationAmount.ratio(categoryAllocationAmount)
          : 0.0,
      color: colorScheme.surface,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  plan.title.sentence(),
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  plan.description.capitalize(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (allocationAmount != null && categoryAllocationAmount != null)
            AmountRatioItem(
              allocationAmount: allocationAmount,
              baseAmount: categoryAllocationAmount,
            ),
        ],
      ),
    );
  }
}
