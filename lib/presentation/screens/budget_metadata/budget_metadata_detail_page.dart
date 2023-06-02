import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../theme.dart';
import '../../utils.dart';
import '../../widgets.dart';

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
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetPlansByMetadataProvider(id: widget.id, budgetId: widget.budgetId)).when(
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
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state});

  final BudgetPlansByMetadataState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final List<BudgetPlanViewModel> data = state.plans;
    final BudgetViewModel? budget = state.budget;
    final Money totalAllocationAmount = state.plans.map((_) => _.allocation?.amount ?? Money.zero).sum();

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
                final BudgetPlanViewModel plan = data.elementAt(index);
                final Money? allocationAmount = plan.allocation?.amount;

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
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemCount: data.length,
            ),
          ),
      ],
    );
  }
}
