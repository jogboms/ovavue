import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
    final bool active = state.budget.endedAt == null;

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
                  onPressed: (String id) => context.router.goToBudgetCategoryDetailForBudget(
                    id: id,
                    budgetId: state.budget.id,
                  ),
                  onExpand: () => context.router.goToGroupedBudgetPlans(
                    budgetId: state.budget.id,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPinnedHeader(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) => ActionButtonRow(
              alignment: Alignment.center,
              actions: <ActionButton>[
                if (active) ...<ActionButton>[
                  ActionButton(
                    icon: Icons.attach_money_outlined,
                    onPressed: () => _handleAllocationAction(context, ref: ref, budget: state.budget),
                  ),
                  ActionButton(
                    icon: Icons.add_chart, // TODO(Jogboms): fix icon
                    onPressed: () => createBudgetPlanAction(
                      context: context,
                      ref: ref,
                      navigateOnComplete: true,
                    ),
                  ),
                  ActionButton(
                    icon: Icons.add_moderator_outlined, // TODO(Jogboms): fix icon
                    onPressed: () => createBudgetCategoryAction(
                      context: context,
                      ref: ref,
                      navigateOnComplete: true,
                    ),
                  ),
                  ActionButton(
                    icon: Icons.edit,
                    onPressed: () => _handleUpdateAction(
                      context,
                      ref: ref,
                      budget: state.budget,
                    ),
                  ),
                ],
                ActionButton(
                  icon: Icons.copy_outlined, // TODO(Jogboms): fix icon
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
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.budget.plans.length,
        ),
        if (state.budget.plans.isEmpty)
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
                  final SelectedBudgetPlanViewModel plan = state.budget.plans[index];

                  return _PlanTile(
                    key: Key(plan.id),
                    plan: plan,
                    budgetAmount: state.budget.amount,
                    onPressed: () => context.router.goToBudgetPlanDetail(
                      id: plan.id,
                      budgetId: state.budget.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                childCount: state.budget.plans.length,
              ),
            ),
          ),
      ],
    );
  }

  void _handleAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required SelectedBudgetViewModel budget,
  }) async {
    final BudgetAllocationEntryResult? result = await showBudgetAllocationEntryForm(
      context: context,
      budgetId: budget.id,
      plansById: budget.plans.map((_) => _.id),
      plan: null,
      allocation: null,
    );
    if (result == null) {
      return;
    }

    await ref.read(budgetPlanProvider).createAllocation(
          CreateBudgetAllocationData(
            amount: result.amount.rawValue,
            budget: ReferenceEntity(id: budget.id, path: budget.path),
            plan: ReferenceEntity(id: result.plan.id, path: result.plan.path),
          ),
        );
  }

  void _handleUpdateAction(
    BuildContext context, {
    required WidgetRef ref,
    required SelectedBudgetViewModel budget,
  }) async {
    final BudgetEntryResult? result = await showBudgetEntryForm(
      context: context,
      type: BudgetEntryType.update,
      budgetId: budget.id,
      index: budget.index,
      title: budget.title,
      amount: budget.amount,
      description: budget.description,
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
        );
  }

  void _handleDuplicateAction(
    BuildContext context, {
    required WidgetRef ref,
    required SelectedBudgetViewModel budget,
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

  final SelectedBudgetViewModel budget;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(budget.title.sentence(), style: textTheme.headlineSmall),
        const SizedBox(height: 4),
        BudgetDurationText(
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

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Money excessAmount = widget.budgetAmount - widget.allocationAmount;
    final Color excessAmountBackgroundColor = colorScheme.mutedBackground;
    final Color excessAmountForegroundColor = colorScheme.onMutedBackground;
    const IconData excessAmountIcon = Icons.padding_outlined;

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
                  sectionsSpace: 4,
                  centerSpaceRadius: 16,
                  sections: <PieChartSectionData>[
                    for (final SelectedBudgetCategoryViewModel category in widget.categories)
                      _derivePieSectionData(
                        amount: category.allocation,
                        backgroundColor: category.colorScheme.background,
                        foregroundColor: category.colorScheme.foreground,
                        icon: category.icon.data,
                      ),
                    _derivePieSectionData(
                      amount: excessAmount,
                      backgroundColor: excessAmountBackgroundColor,
                      foregroundColor: excessAmountForegroundColor,
                      icon: excessAmountIcon,
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
                  for (final SelectedBudgetCategoryViewModel category in widget.categories)
                    _CategoryChip(
                      key: Key(category.id),
                      title: category.title,
                      icon: category.icon.data,
                      allocationAmount: category.allocation,
                      backgroundColor: category.colorScheme.background,
                      foregroundColor: category.colorScheme.foreground,
                      budgetAmount: widget.budgetAmount,
                      onPressed: () => widget.onPressed(category.id),
                    ),
                  _CategoryChip(
                    key: Key(l10n.excessLabel),
                    title: l10n.excessLabel,
                    icon: excessAmountIcon,
                    allocationAmount: excessAmount,
                    backgroundColor: excessAmountBackgroundColor,
                    foregroundColor: excessAmountForegroundColor,
                    budgetAmount: widget.budgetAmount,
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.fullscreen_exit_outlined),
                onPressed: widget.onExpand,
              ),
              IconButton(
                icon: const Icon(Icons.repeat),
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
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    final double dimension = MediaQuery.of(context).size.shortestSide;
    final ThemeData theme = Theme.of(context);
    final TextStyle labelTextStyle = theme.textTheme.labelLarge!.copyWith(
      fontWeight: AppFontWeight.bold,
      color: foregroundColor,
      letterSpacing: .01,
    );

    return PieChartSectionData(
      title: amount.percentage(widget.budgetAmount),
      value: amount.rawValue.roundToDouble(),
      color: backgroundColor,
      radius: dimension / 2.5,
      badgeWidget: CircleAvatar(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        child: Icon(icon),
      ),
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

  final SelectedBudgetPlanViewModel plan;
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
                const SizedBox(width: 6.0),
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
