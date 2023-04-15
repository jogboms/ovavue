import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils.dart';
import '../../widgets.dart';
import 'providers/selected_budget_category_provider.dart';
import 'widgets/budget_category_header.dart';
import 'widgets/budget_category_plan_tile.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  const BudgetCategoryDetailPage({super.key, required this.id});

  final String id;

  @override
  State<BudgetCategoryDetailPage> createState() => BudgetCategoryDetailPageState();
}

@visibleForTesting
class BudgetCategoryDetailPageState extends State<BudgetCategoryDetailPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetCategoryProvider(widget.id)).when(
                  data: (BudgetCategoryState data) => _ContentDataView(
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

  final BudgetCategoryState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
              allocationAmount: null,
              budgetAmount: null,
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
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.plans.length,
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
                  categoryAllocationAmount: null,
                  onPressed: () {
                    // TODO(Jogboms): ???
                  },
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
