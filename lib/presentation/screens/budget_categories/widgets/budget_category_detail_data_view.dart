import 'package:flutter/material.dart';

import '../../../models.dart';
import '../../../routing.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../providers/budget_category_state.dart';
import '../providers/models.dart';
import 'budget_category_header.dart';
import 'budget_category_plan_tile.dart';
import 'budget_plan_selection_picker.dart';

class BudgetCategoryDetailDataView extends StatelessWidget {
  const BudgetCategoryDetailDataView({super.key, required this.state});

  final BudgetCategoryState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: const Text(''),
          asSliver: true,
          centerTitle: true,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            BudgetCategoryHeader(
              category: state.category,
              allocationAmount: state.allocation,
              budgetAmount: state.budget?.amount,
            ),
            ActionButtonRow(
              actions: <ActionButton>[
                ActionButton(
                  icon: Icons.add_moderator_outlined, // TODO(Jogboms): fix icon
                  onPressed: () => _handlePlanAddition(context),
                ),
                ActionButton(
                  icon: Icons.edit,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8.0),
          ]),
        ),
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.plans.length,
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          sliver: SliverList(
            delegate: SliverSeparatorBuilderDelegate(
              builder: (BuildContext context, int index) {
                final BudgetCategoryPlanViewModel plan = state.plans[index];

                return BudgetCategoryPlanTile(
                  key: Key(plan.id),
                  plan: plan,
                  categoryAllocationAmount: state.allocation,
                  onPressed: () => context.router.goToBudgetPlanDetail(
                    id: plan.id,
                    budgetId: state.budget?.id,
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              childCount: state.plans.length,
            ),
          ),
        ),
      ],
    );
  }

  void _handlePlanAddition(BuildContext context) async {
    final BudgetPlanViewModel? plan = await showModalBottomSheet(
      context: context,
      builder: (_) => const BudgetPlanSelectionPicker(),
    );
    if (plan == null) {
      return;
    }

    // TODO(Jogboms): add category to plan
  }
}
