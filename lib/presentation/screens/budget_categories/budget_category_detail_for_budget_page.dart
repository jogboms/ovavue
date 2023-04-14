import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../routing.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/selected_budget_category_by_budget_provider.dart';
import 'widgets/budget_category_header.dart';
import 'widgets/budget_category_plan_tile.dart';

class BudgetCategoryDetailForBudgetPage extends StatefulWidget {
  const BudgetCategoryDetailForBudgetPage({super.key, required this.id, required this.budgetId});

  final String id;
  final String budgetId;

  @override
  State<BudgetCategoryDetailForBudgetPage> createState() => BudgetCategoryDetailForBudgetPageState();
}

@visibleForTesting
class BudgetCategoryDetailForBudgetPageState extends State<BudgetCategoryDetailForBudgetPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetCategoryByBudgetProvider(id: widget.id, budgetId: widget.budgetId)).when(
                  data: (BudgetCategoryByBudgetState data) => _ContentDataView(
                    key: dataViewKey,
                    state: data,
                  ),
                  error: ErrorView.new,
                  loading: () => child!,
                ),
        child: const LoadingView(),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state});

  final BudgetCategoryByBudgetState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

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
              budgetAmount: state.budget.amount,
            ),
            ActionButtonRow(
              actions: <ActionButton>[
                ActionButton(
                  icon: Icons.add_moderator_outlined,
                  onPressed: () {},
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
        SliverPinnedHeader(
          child: Container(
            color: colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              context.l10n.associatedPlansTitle,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
          ),
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
                    budgetId: state.budget.id,
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
}
