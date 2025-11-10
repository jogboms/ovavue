import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class GroupedBudgetPlansPage extends StatefulWidget {
  const GroupedBudgetPlansPage({super.key, required this.budgetId});

  final String budgetId;

  @override
  State<GroupedBudgetPlansPage> createState() => _GroupedBudgetPlansPageState();
}

class _GroupedBudgetPlansPageState extends State<GroupedBudgetPlansPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  var _expandAllGroups = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(selectedBudgetProvider(widget.budgetId))
          .when(
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

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state, required this.expandAllGroups});

  final BudgetState state;
  final bool expandAllGroups;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final plansByCategory = state.plans.groupListsBy(
      (BudgetPlanViewModel e) => e.category.id,
    );

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
          asSliver: true,
          centerTitle: true,
        ),
        if (state.categories.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          // ignore: false positive
          for (final (BudgetCategoryViewModel category, Money allocation) in state.categories)
            SliverPadding(
              padding: const EdgeInsets.only(top: 4),
              sliver: SliverExpandableGroup<BudgetPlanViewModel>(
                key: Key(category.id),
                expanded: expandAllGroups,
                header: _Header(category: category, allocationAmount: allocation),
                values: plansByCategory[category.id]!,
                itemBuilder: (BudgetPlanViewModel plan) => _PlanTile(
                  key: Key(plan.id),
                  plan: plan,
                  categoryAllocationAmount: allocation,
                  onPressed: () => context.router.goToBudgetPlanDetail(
                    id: plan.id,
                    budgetId: state.budget.id,
                    entrypoint: BudgetPlanDetailPageEntrypoint.budget,
                  ),
                ),
              ),
            ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.paddingOf(context).bottom,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.category, required this.allocationAmount});

  final BudgetCategoryViewModel category;
  final Money allocationAmount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
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
    final theme = Theme.of(context);

    final allocation = plan.allocation;

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
            ),
        ],
      ),
    );
  }
}
