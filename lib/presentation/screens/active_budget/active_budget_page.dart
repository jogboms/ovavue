import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/core.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../theme.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/active_budget_provider.dart';

class ActiveBudgetPage extends StatefulWidget {
  const ActiveBudgetPage({super.key});

  @override
  State<ActiveBudgetPage> createState() => ActiveBudgetPageState();
}

@visibleForTesting
class ActiveBudgetPageState extends State<ActiveBudgetPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(activeBudgetProvider).when(
              data: (ActiveBudgetState data) => _ContentDataView(
                key: dataViewKey,
                state: data,
              ),
              error: ErrorView.new,
              loading: () => child!,
            ),
        child: const LoadingView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.menu),
        onPressed: () async {
          late final AppRouter router = context.router;
          final _BottomSheetChoice? result = await showModalBottomSheet<_BottomSheetChoice>(
            context: context,
            builder: (_) => const _BottomSheetOptions(),
          );
          if (result == null) {
            return;
          }

          switch (result) {
            case _BottomSheetChoice.budgets:
              // TODO(Jogboms): Not implemented
              break;
            case _BottomSheetChoice.plans:
              await router.goToBudgetPlans();
              break;
            case _BottomSheetChoice.categories:
              await router.goToBudgetCategories();
              break;
            case _BottomSheetChoice.settings:
              // TODO(Jogboms): Not implemented
              break;
          }
        },
      ),
    );
  }
}

enum _BottomSheetChoice {
  budgets,
  plans,
  categories,
  settings,
}

class _BottomSheetOptions extends StatelessWidget {
  const _BottomSheetOptions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _BottomSheetChoice choice in _BottomSheetChoice.values)
            ListTile(
              key: Key(choice.name),
              onTap: () => Navigator.of(context).pop(choice),
              title: Text(choice.name.capitalize(), textAlign: TextAlign.center),
            ),
        ],
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state});

  final ActiveBudgetState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                  allocationAmount: state.budget.amount - state.allocation,
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
          child: ActionButtonRow(
            actions: <ActionButton>[
              ActionButton(
                icon: Icons.add_chart,
                onPressed: () {},
              ),
              ActionButton(
                icon: Icons.add_moderator_outlined,
                onPressed: () {},
              ),
              ActionButton(
                icon: Icons.edit,
                onPressed: () {},
              ),
              ActionButton(
                icon: Icons.copy_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.budget.plans.length,
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: MediaQuery.paddingOf(context).bottom + 72,
          ),
          sliver: SliverList(
            delegate: SliverSeparatorBuilderDelegate(
              builder: (BuildContext context, int index) {
                final ActiveBudgetPlanViewModel plan = state.budget.plans[index];

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
}

class _AppBarText extends StatelessWidget {
  const _AppBarText({required this.budget});

  final ActiveBudgetViewModel budget;

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

  final List<ActiveBudgetCategoryViewModel> categories;
  final Money budgetAmount;
  final Money allocationAmount;
  final ValueChanged<String> onPressed;
  final VoidCallback onExpand;

  @override
  State<_CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<_CategoryView> {
  _CategoryViewType _type = _CategoryViewType.values.random();

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Money excessAmount = widget.budgetAmount - widget.allocationAmount;
    final Color excessAmountBackgroundColor = colorScheme.secondaryContainer;
    final Color excessAmountForegroundColor = colorScheme.onSecondaryContainer;
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
                  sectionsSpace: 2,
                  centerSpaceRadius: 4,
                  sections: <PieChartSectionData>[
                    for (final ActiveBudgetCategoryViewModel category in widget.categories)
                      _derivePieSectionData(
                        amount: category.allocation,
                        backgroundColor: category.backgroundColor,
                        foregroundColor: category.foregroundColor,
                        icon: category.icon,
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
                  for (final ActiveBudgetCategoryViewModel category in widget.categories)
                    _CategoryChip(
                      key: Key(category.id),
                      title: category.title,
                      icon: category.icon,
                      allocationAmount: category.allocation,
                      backgroundColor: category.backgroundColor,
                      foregroundColor: category.foregroundColor,
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
    final double dimension = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);
    final TextStyle labelTextStyle = theme.textTheme.labelSmall!.copyWith(
      fontWeight: AppFontWeight.bold,
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
    final double gradientRatio = allocationAmount.ratio(budgetAmount);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: backgroundColor.withOpacity(.025)),
          ),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: <Color>[backgroundColor, backgroundColor, Colors.transparent],
                stops: <double>[0, gradientRatio, gradientRatio],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 20, color: foregroundColor),
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
          ),
        ),
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

  final ActiveBudgetPlanViewModel plan;
  final Money budgetAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final BudgetAllocationViewModel? allocation = plan.allocation;

    return AmountRatioDecoratedBox(
      color: plan.category.backgroundColor,
      ratio: allocation?.amount.ratio(budgetAmount) ?? 0.0,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(plan.category.icon),
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
