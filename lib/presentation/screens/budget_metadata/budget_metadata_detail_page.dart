import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetMetadataDetailPage extends StatefulWidget {
  const BudgetMetadataDetailPage({
    super.key,
    required this.id,
    required this.budgetId,
  });

  final String id;
  final String? budgetId;

  @override
  State<BudgetMetadataDetailPage> createState() => BudgetMetadataDetailPageState();
}

@visibleForTesting
class BudgetMetadataDetailPageState extends State<BudgetMetadataDetailPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(selectedBudgetPlansByMetadataProvider(id: widget.id, budgetId: widget.budgetId))
          .when(
            data: (BudgetPlansByMetadataState data) => _ContentDataView(
              key: dataViewKey,
              state: data,
            ),
            error: ErrorView.new,
            loading: () => child!,
            skipLoadingOnReload: true,
          ),
      child: const LoadingView(),
    ),
  );
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state});

  final BudgetPlansByMetadataState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final data = state.plans;
    final budget = state.budget;
    final totalAllocationAmount = state.plans.map((BudgetPlanViewModel e) => e.allocation?.amount ?? Money.zero).sum();

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Column(
            children: <Widget>[
              Text(
                '#${state.metadata.title}',
                style: textTheme.bodyMedium,
                maxLines: 1,
              ),
              Text(state.metadata.value, maxLines: 1),
            ],
          ),
          asSliver: true,
          centerTitle: true,
        ),
        SliverList.list(
          children: <Widget>[
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.key.title.sentence(),
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: AppFontWeight.semibold,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          state.key.description.capitalize(),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (budget != null)
                    AmountRatioItem.large(
                      allocationAmount: totalAllocationAmount,
                      baseAmount: budget.amount,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
        SliverPinnedTitleCountHeader.count(
          title: context.l10n.associatedPlansTitle,
          count: state.plans.length,
        ),
        if (data.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          SliverPadding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            sliver: SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final plan = data.elementAt(index);
                final allocationAmount = plan.allocation?.amount;

                return BudgetPlanListTile(
                  key: Key(plan.id),
                  plan: plan,
                  trailing: allocationAmount != null && budget != null
                      ? AmountRatioItem(
                          allocationAmount: allocationAmount,
                          baseAmount: budget.amount,
                        )
                      : null,
                  onTap: () => context.router.goToBudgetPlanDetail(
                    id: plan.id,
                    budgetId: budget?.id,
                    entrypoint: BudgetPlanDetailPageEntrypoint.metadata,
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemCount: data.length,
            ),
          ),
      ],
    );
  }
}
