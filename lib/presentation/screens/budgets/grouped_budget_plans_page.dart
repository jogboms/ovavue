import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../constants.dart';
import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../theme.dart';
import '../../utils.dart';
import '../../widgets.dart';

class GroupedBudgetPlansPage extends StatefulWidget {
  const GroupedBudgetPlansPage({super.key, required this.budgetId});

  final String budgetId;

  @override
  State<GroupedBudgetPlansPage> createState() => _GroupedBudgetPlansPageState();
}

class _GroupedBudgetPlansPageState extends State<GroupedBudgetPlansPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  bool _expandAllGroups = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetProvider(widget.budgetId)).when(
                  data: (BudgetState data) => _ContentDataView(
                    key: dataViewKey,
                    state: data,
                    expandAllGroups: _expandAllGroups,
                  ),
                  error: ErrorView.new,
                  loading: () => child!,
                ),
        child: const LoadingView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(AppIcons.toggleAll),
        onPressed: () => setState(() => _expandAllGroups = !_expandAllGroups),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state, required this.expandAllGroups});

  final BudgetState state;
  final bool expandAllGroups;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    final Map<String, List<BudgetPlanViewModel>> plansByCategory = state.plans.groupListsBy((_) => _.category.id);

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Column(
            children: <Widget>[
              Text(context.l10n.totalBudgetCaption.toUpperCase(), style: textTheme.labelMedium),
              Text(
                '${state.budget.amount}',
                style: textTheme.titleLarge?.copyWith(fontWeight: AppFontWeight.semibold),
              ),
            ],
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          asSliver: true,
          centerTitle: true,
        ),
        if (state.categories.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          // ignore: prefer_final_locals, false positive
          for (final (BudgetCategoryViewModel category, Money allocation) in state.categories)
            SliverPadding(
              padding: const EdgeInsets.only(top: 4),
              sliver: _SliverPlansGroup(
                key: Key(category.id),
                budget: state.budget,
                category: category,
                allocationAmount: allocation,
                plans: plansByCategory[category.id]!,
                expanded: expandAllGroups,
              ),
            ),
      ],
    );
  }
}

class _SliverPlansGroup extends StatefulWidget {
  const _SliverPlansGroup({
    super.key,
    required this.budget,
    required this.category,
    required this.allocationAmount,
    required this.plans,
    required this.expanded,
  });

  final BudgetViewModel budget;
  final BudgetCategoryViewModel category;
  final Money allocationAmount;
  final List<BudgetPlanViewModel> plans;
  final bool expanded;

  @override
  State<_SliverPlansGroup> createState() => _SliverPlansGroupState();
}

class _SliverPlansGroupState extends State<_SliverPlansGroup> {
  late bool _expanded = widget.expanded;

  @override
  void didUpdateWidget(covariant _SliverPlansGroup oldWidget) {
    if (widget.expanded != _expanded) {
      setState(() => _expanded = widget.expanded);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SliverStickyHeader(
      header: Material(
        child: InkWell(
          child: Ink(
            color: colorScheme.surface,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                _Header(
                  key: Key(widget.category.id),
                  category: widget.category,
                  allocationAmount: widget.allocationAmount,
                ),
                AnimatedRotation(
                  turns: _expanded ? 0 : 0.5,
                  duration: kThemeChangeDuration,
                  child: const Icon(AppIcons.arrowDown),
                ),
              ],
            ),
          ),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
      ),
      sliver: _expanded
          ? SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList(
                delegate: SliverSeparatorBuilderDelegate(
                  builder: (BuildContext context, int index) {
                    final BudgetPlanViewModel plan = widget.plans[index];

                    return _PlanTile(
                      key: Key(plan.id),
                      plan: plan,
                      categoryAllocationAmount: widget.allocationAmount,
                      onPressed: () => context.router.goToBudgetPlanDetail(
                        id: plan.id,
                        budgetId: widget.budget.id,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  childCount: widget.plans.length,
                ),
              ),
            )
          : const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key, required this.category, required this.allocationAmount});

  final BudgetCategoryViewModel category;
  final Money allocationAmount;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Row(
        children: <Widget>[
          BudgetCategoryAvatar.small(
            colorScheme: category.colorScheme,
            icon: category.icon.data,
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(category.title.sentence(), style: textTheme.bodyMedium, maxLines: 1),
              const SizedBox(height: 2.0),
              Text('$allocationAmount', style: textTheme.titleMedium),
            ],
          ),
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

  final BudgetPlanViewModel plan;
  final Money categoryAllocationAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final BudgetAllocationViewModel? allocation = plan.allocation;

    return AmountRatioDecoratedBox(
      color: plan.category.colorScheme.background,
      ratio: allocation?.amount.ratio(categoryAllocationAmount) ?? 0.0,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(plan.title.sentence(), style: theme.textTheme.titleSmall),
                const SizedBox(height: 4.0),
                Text(plan.category.title.sentence(), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          if (allocation != null)
            AmountRatioItem(
              allocationAmount: allocation.amount,
              baseAmount: categoryAllocationAmount,
            )
        ],
      ),
    );
  }
}
