import 'package:flutter/material.dart';

import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetCategoryHeader extends StatelessWidget {
  const BudgetCategoryHeader({
    super.key,
    required this.category,
    required this.budgetAmount,
    required this.allocationAmount,
  });

  final BudgetCategoryViewModel category;
  final Money? allocationAmount;
  final Money? budgetAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final allocationAmount = this.allocationAmount;
    final budgetAmount = this.budgetAmount;
    final foregroundColor = category.colorScheme.foreground;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BudgetCategoryAvatar.inverse(
            colorScheme: category.colorScheme,
            icon: category.icon.data,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  category.title.sentence(),
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: AppFontWeight.semibold,
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  category.description.capitalize(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
          if (allocationAmount != null && allocationAmount != Money.zero && budgetAmount != null) ...<Widget>[
            const SizedBox(width: 8.0),
            AmountRatioItem.large(
              allocationAmount: allocationAmount,
              baseAmount: budgetAmount,
              foregroundColor: foregroundColor,
            ),
          ],
        ],
      ),
    );
  }
}
