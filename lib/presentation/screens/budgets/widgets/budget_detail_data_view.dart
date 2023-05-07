import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../constants.dart';
import '../../../models.dart';
import '../../../routing.dart';
import '../../../state.dart';
import '../../../theme.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../providers/budget_provider.dart';
import '../utils/create_budget_action.dart';
import 'budget_entry_form.dart';

class BudgetDetailDataView extends StatelessWidget {
  const BudgetDetailDataView({super.key, required this.state});

  final BudgetState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppRouter router = context.router;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: _AppBarText(budget: state.budget),
          asSliver: true,
          centerTitle: true,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _HeaderText(budgetAmount: state.budget.amount),
                _CategoryView(
                  categories: state.categories,
                  budgetAmount: state.budget.amount,
                  allocationAmount: state.allocation,
                  onPressed: (String id) => router.goToBudgetCategoryDetailForBudget(
                    id: id,
                    budgetId: state.budget.id,
                  ),
                  onExpand: () => router.goToGroupedBudgetPlans(
                    budgetId: state.budget.id,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        SliverPinnedHeader(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) => ActionButtonRow(
              alignment: Alignment.center,
              backgroundColor: theme.scaffoldBackgroundColor,
              actions: <ActionButton>[
                if (state.budget.active) ...<ActionButton>[
                  ActionButton(
                    icon: AppIcons.addAllocation,
                    onPressed: () => _handleAllocationAction(
                      context,
                      ref: ref,
                      budget: state.budget,
                      plans: state.plans,
                    ),
                  ),
                  ActionButton(
                    icon: AppIcons.addPlan,
                    onPressed: () => createBudgetPlanAction(
                      context: context,
                      ref: ref,
                      navigateOnComplete: true,
                    ),
                  ),
                  ActionButton(
                    icon: AppIcons.addCategory,
                    onPressed: () => createBudgetCategoryAction(
                      context: context,
                      ref: ref,
                      navigateOnComplete: true,
                    ),
                  ),
                  ActionButton(
                    icon: AppIcons.edit,
                    onPressed: () => _handleUpdateAction(
                      context,
                      ref: ref,
                      budget: state.budget,
                    ),
                  ),
                ] else
                  ActionButton(
                    icon: AppIcons.activateBudget,
                    onPressed: () => _handleActivateAction(
                      context,
                      ref: ref,
                      budget: state.budget,
                    ),
                  ),
                ActionButton(
                  icon: AppIcons.duplicateBudget,
                  onPressed: () => _handleDuplicateAction(
                    context,
                    ref: ref,
                    budget: state.budget,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.plans.length,
        ),
        if (state.plans.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          SliverPadding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: MediaQuery.paddingOf(context).bottom + 72,
            ),
            sliver: SliverList(
              delegate: SliverSeparatorBuilderDelegate(
                builder: (BuildContext context, int index) {
                  final BudgetPlanViewModel plan = state.plans[index];

                  return _PlanTile(
                    key: Key(plan.id),
                    plan: plan,
                    budgetAmount: state.budget.amount,
                    onPressed: () => router.goToBudgetPlanDetail(
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

  void _handleAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
    required List<BudgetPlanViewModel> plans,
  }) async {
    final BudgetAllocationEntryResult? result = await showBudgetAllocationEntryForm(
      context: context,
      budgetId: budget.id,
      plansById: plans.map((_) => _.id),
      plan: null,
      allocation: null,
    );
    if (result == null) {
      return;
    }

    await ref.read(budgetPlanProvider).createAllocation(
          CreateBudgetAllocationData(
            amount: result.amount.rawValue,
            budget: (id: budget.id, path: budget.path),
            plan: (id: result.plan.id, path: result.plan.path),
          ),
        );
  }

  void _handleUpdateAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
  }) async {
    final BudgetEntryResult? result = await showBudgetEntryForm(
      context: context,
      type: BudgetEntryType.update,
      budgetId: budget.id,
      index: budget.index,
      title: budget.title,
      amount: budget.amount,
      description: budget.description,
      active: budget.active,
      startedAt: budget.startedAt,
      endedAt: budget.endedAt,
      createdAt: budget.createdAt,
    );
    if (result == null) {
      return;
    }

    await ref.read(budgetProvider).update(
          id: budget.id,
          path: budget.path,
          title: result.title,
          amount: result.amount.rawValue,
          description: result.description,
          active: result.active,
          startedAt: result.startedAt,
          endedAt: result.endedAt,
        );
  }

  void _handleActivateAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
  }) async =>
      ref.read(budgetProvider).activate(id: budget.id, path: budget.path);

  void _handleDuplicateAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
  }) async =>
      createBudgetAction(
        context,
        ref: ref,
        budgetId: budget.id,
        index: budget.index,
        amount: budget.amount,
        description: budget.description,
        createdAt: budget.createdAt,
        navigateOnComplete: budget.endedAt != null,
      );
}

class _AppBarText extends StatelessWidget {
  const _AppBarText({required this.budget});

  final BudgetViewModel budget;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(
          budget.title.sentence(),
          style: textTheme.headlineSmall?.copyWith(fontWeight: AppFontWeight.semibold),
        ),
        BudgetDurationText.medium(
          startedAt: budget.startedAt,
          endedAt: budget.endedAt,
        ),
      ],
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText({required this.budgetAmount});

  final Money budgetAmount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        '$budgetAmount',
        textAlign: TextAlign.center,
        style: theme.textTheme.displaySmall?.copyWith(
          color: theme.colorScheme.onSurface,
          letterSpacing: 1.25,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}

enum _CategoryViewType {
  pieChart,
  chips,
}

class _CategoryView extends StatefulWidget {
  const _CategoryView({
    required this.categories,
    required this.budgetAmount,
    required this.allocationAmount,
    required this.onPressed,
    required this.onExpand,
  });

  final List<SelectedBudgetCategoryViewModel> categories;
  final Money budgetAmount;
  final Money allocationAmount;
  final ValueChanged<String> onPressed;
  final VoidCallback onExpand;

  @override
  State<_CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<_CategoryView> {
  _CategoryViewType _type = _CategoryViewType.pieChart;
  static const double _innerPieChartRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context);

    final Money excessAmount = widget.budgetAmount - widget.allocationAmount;
    const BudgetCategoryColorScheme excessAmountColorScheme = BudgetCategoryColorScheme.excess;
    const BudgetCategoryIcon excessAmountIcon = BudgetCategoryIcon.excess;

    return AnimatedSize(
      duration: kThemeChangeDuration,
      curve: Curves.easeInOut,
      child: Column(
        children: <Widget>[
          if (_type == _CategoryViewType.pieChart)
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: _innerPieChartRadius / 4,
                  centerSpaceRadius: _innerPieChartRadius,
                  sections: <PieChartSectionData>[
                    // ignore: prefer_final_locals, false positive
                    for (final (BudgetCategoryViewModel category, Money allocation) in widget.categories)
                      _derivePieSectionData(
                        amount: allocation,
                        colorScheme: category.colorScheme,
                        icon: category.icon.data,
                      ),
                    _derivePieSectionData(
                      amount: excessAmount,
                      colorScheme: excessAmountColorScheme,
                      icon: excessAmountIcon.data,
                    ),
                  ],
                ),
              ),
            ),
          if (_type == _CategoryViewType.chips)
            Padding(
              padding: const EdgeInsets.only(top: 36, bottom: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  // ignore: prefer_final_locals, false positive
                  for (final (BudgetCategoryViewModel category, Money allocation) in widget.categories)
                    _CategoryChip(
                      key: Key(category.id),
                      title: category.title,
                      icon: category.icon.data,
                      allocationAmount: allocation,
                      backgroundColor: category.colorScheme.background,
                      foregroundColor: category.colorScheme.foreground,
                      budgetAmount: widget.budgetAmount,
                      onPressed: () => widget.onPressed(category.id),
                    ),
                  _CategoryChip(
                    key: Key(l10n.excessLabel),
                    title: l10n.excessLabel,
                    icon: excessAmountIcon.data,
                    allocationAmount: excessAmount,
                    backgroundColor: excessAmountColorScheme.background,
                    foregroundColor: excessAmountColorScheme.foreground,
                    budgetAmount: widget.budgetAmount,
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(AppIcons.expand),
                onPressed: widget.onExpand,
              ),
              IconButton(
                icon: const Icon(AppIcons.toggle),
                onPressed: () => setState(() {
                  _type = _CategoryViewType.values[(_type.index + 1) % _CategoryViewType.values.length];
                }),
              )
            ],
          ),
        ],
      ),
    );
  }

  PieChartSectionData _derivePieSectionData({
    required Money amount,
    required IconData icon,
    required BudgetCategoryColorScheme colorScheme,
  }) {
    final double dimension = MediaQuery.of(context).size.shortestSide;
    final ThemeData theme = Theme.of(context);
    final TextStyle labelTextStyle = theme.textTheme.labelLarge!.copyWith(
      fontWeight: AppFontWeight.bold,
      color: colorScheme.foreground,
      letterSpacing: .01,
    );

    return PieChartSectionData(
      title: amount.percentage(widget.budgetAmount),
      value: amount.rawValue.roundToDouble(),
      color: colorScheme.background,
      radius: (dimension / 2.5) - _innerPieChartRadius,
      badgeWidget: BudgetCategoryAvatar(colorScheme: colorScheme, icon: icon),
      badgePositionPercentageOffset: .98,
      showTitle: amount.ratio(widget.budgetAmount) > .025,
      titleStyle: labelTextStyle,
      titlePositionPercentageOffset: .75,
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    super.key,
    required this.title,
    required this.icon,
    required this.allocationAmount,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.budgetAmount,
    this.onPressed,
  });

  final String title;
  final IconData icon;
  final Money allocationAmount;
  final Color backgroundColor;
  final Color foregroundColor;
  final Money budgetAmount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AmountRatioDecoratedBox(
      onPressed: onPressed,
      color: backgroundColor,
      ratio: allocationAmount.ratio(budgetAmount),
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 20, color: theme.colorScheme.onSurface),
          const SizedBox(width: 12),
          Column(
            children: <Widget>[
              Text(title.sentence(), style: theme.textTheme.bodyLarge),
              Text(
                '$allocationAmount (${allocationAmount.percentage(budgetAmount)})',
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    super.key,
    required this.plan,
    required this.budgetAmount,
    required this.onPressed,
  });

  final BudgetPlanViewModel plan;
  final Money budgetAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final BudgetAllocationViewModel? allocation = plan.allocation;

    return AmountRatioDecoratedBox(
      color: plan.category.colorScheme.background,
      ratio: allocation?.amount.ratio(budgetAmount) ?? 0.0,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(plan.category.icon.data),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      plan.title.sentence(),
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      plan.category.title.sentence(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (allocation != null)
            AmountRatioItem(
              allocationAmount: allocation.amount,
              baseAmount: budgetAmount,
            )
        ],
      ),
    );
  }
}
