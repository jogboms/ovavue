import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../constants/app_routes.dart';
import '../../theme.dart';
import '../../utils.dart';
import '../../widgets.dart';
import '../budget_plans/budget_plan_detail_page.dart';
import 'providers/selected_budget_category_by_budget_provider.dart';

class BudgetCategoryDetailForBudgetPage extends StatefulWidget {
  const BudgetCategoryDetailForBudgetPage({super.key, required this.id, required this.budgetId});

  final String id;
  final String budgetId;

  static PageRoute<void> route({required String id, required String budgetId}) {
    return MaterialPageRoute<void>(
      builder: (_) => BudgetCategoryDetailForBudgetPage(id: id, budgetId: budgetId),
      settings: const RouteSettings(name: AppRoutes.budgetCategoryDetail),
    );
  }

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
            _Header(state: state),
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

                return _PlanTile(
                  key: Key(plan.id),
                  plan: plan,
                  categoryAllocationAmount: state.allocation,
                  onPressed: () => Navigator.of(context).push(
                    BudgetPlanDetailPage.route(
                      id: plan.id,
                      budgetId: state.budget.id,
                    ),
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

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final BudgetCategoryByBudgetState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: state.category.backgroundColor,
            child: Icon(
              state.category.icon,
              color: state.category.foregroundColor,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  state.category.title.sentence(),
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: AppFontWeight.semibold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  state.category.description.capitalize(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          if (state.allocation != Money.zero) ...<Widget>[
            const SizedBox(width: 8.0),
            AmountRatioItem.large(
              allocationAmount: state.allocation,
              baseAmount: state.budget.amount,
            )
          ]
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    super.key,
    required this.plan,
    required this.categoryAllocationAmount,
    required this.onPressed,
  });

  final BudgetCategoryPlanViewModel plan;
  final Money categoryAllocationAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final Money? allocation = plan.allocation;

    return AmountRatioDecoratedBox(
      ratio: allocation?.ratio(categoryAllocationAmount) ?? 0.0,
      color: colorScheme.background,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              plan.title.sentence(),
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ),
          if (allocation != null)
            AmountRatioItem(
              allocationAmount: allocation,
              baseAmount: categoryAllocationAmount,
            ),
        ],
      ),
    );
  }
}
