import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../../widgets.dart';
import '../providers/models.dart';

class BudgetCategoryPlanTile extends StatelessWidget {
  const BudgetCategoryPlanTile({
    super.key,
    required this.plan,
    required this.categoryAllocationAmount,
    required this.onPressed,
  });

  final BudgetCategoryPlanViewModel plan;
  final Money? categoryAllocationAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final Money? allocation = plan.allocation;
    final Money? categoryAllocationAmount = this.categoryAllocationAmount;

    return AmountRatioDecoratedBox(
      ratio: categoryAllocationAmount != null ? allocation?.ratio(categoryAllocationAmount) ?? 0.0 : 0.0,
      color: colorScheme.background,
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
                    color: colorScheme.onBackground,
                  ),
                ),
                Text(
                  plan.description.capitalize(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (allocation != null && categoryAllocationAmount != null)
            AmountRatioItem(
              allocationAmount: allocation,
              baseAmount: categoryAllocationAmount,
            ),
        ],
      ),
    );
  }
}
