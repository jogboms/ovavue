import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/data/repositories/extensions.dart';
import 'package:ovavue/presentation.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
          late final NavigatorState navigator = Navigator.of(context);
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
              await navigator.push(BudgetPlansPage.route());
              break;
            case _BottomSheetChoice.categories:
              await navigator.push(BudgetCategoriesPage.route());
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
                  onPressed: (String id) => Navigator.of(context).push(
                    BudgetCategoryDetailForBudgetPage.route(
                      id: id,
                      budgetId: state.budget.id,
                    ),
                  ),
                  onExpand: () => Navigator.of(context).push(
                    GroupedBudgetPlansPage.route(
                      budgetId: state.budget.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPinnedHeader(
          child: _ActionButtonRow(
            actions: <_ActionButton>[
              _ActionButton(
                icon: Icons.add_chart,
                onPressed: () {},
              ),
              _ActionButton(
                icon: Icons.add_moderator_outlined,
                onPressed: () {},
              ),
              _ActionButton(
                icon: Icons.edit,
                onPressed: () {},
              ),
              _ActionButton(
                icon: Icons.copy_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: MediaQuery.paddingOf(context).bottom + 72,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final ActiveBudgetPlanViewModel plan = state.budget.plans[index];

                return _PlanTile(
                  key: Key(plan.id),
                  plan: plan,
                  budgetAmount: state.budget.amount,
                  onPressed: () => Navigator.of(context).push(
                    BudgetPlanDetailPage.route(
                      id: plan.id,
                      budgetId: state.budget.id,
                    ),
                  ),
                );
              },
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
        Text(budget.title, style: textTheme.labelLarge),
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
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        '$budgetAmount',
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onSurface,
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

    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: backgroundColor.withOpacity(.15)),
        ),
        child: Container(
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
              Icon(icon, size: 16, color: foregroundColor),
              const SizedBox(width: 12),
              Column(
                children: <Widget>[
                  Text(title.sentence(), style: theme.textTheme.bodySmall),
                  Text(
                    '$allocationAmount (${allocationAmount.percentage(budgetAmount)})',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}

class _ActionButtonRow extends StatelessWidget {
  const _ActionButtonRow({required this.actions});

  final List<_ActionButton> actions;

  static const double _padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _padding),
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: _padding,
        children: actions,
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
    final double gradientRatio = allocation?.amount.ratio(budgetAmount) ?? 0.0;
    final Color categoryColor = plan.category.backgroundColor;

    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: categoryColor.withOpacity(.015),
          border: Border.all(color: categoryColor.withOpacity(.15)),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[categoryColor, categoryColor, Colors.transparent],
              stops: <double>[0, gradientRatio, gradientRatio],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                  budgetAmount: budgetAmount,
                )
            ],
          ),
        ),
      ),
    );
  }
}
