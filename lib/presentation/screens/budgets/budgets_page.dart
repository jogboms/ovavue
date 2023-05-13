import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'utils/create_budget_action.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  BudgetsPageState createState() => BudgetsPageState();
}

@visibleForTesting
class BudgetsPageState extends State<BudgetsPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetsProvider).when(
              data: (List<BudgetViewModel> data) => _ContentDataView(
                key: dataViewKey,
                data: data,
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
  const _ContentDataView({super.key, required this.data});

  final List<BudgetViewModel> data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.budgetsPageTitle),
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
              alignment: Alignment.center,
              actions: <ActionButton>[
                ActionButton(
                  icon: AppIcons.plus,
                  onPressed: () => createBudgetAction(
                    context,
                    ref: ref,
                    navigateOnComplete: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (data.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          SliverPadding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final BudgetViewModel budget = data[index];

                  return BudgetListTile(
                    key: Key(budget.id),
                    id: budget.id,
                    title: budget.title,
                    budgetAmount: budget.amount,
                    allocationAmount: null,
                    active: budget.active,
                    startedAt: budget.startedAt,
                    endedAt: budget.endedAt,
                    onTap: () => context.router.goToBudgetDetail(id: budget.id),
                  );
                },
                childCount: data.length,
              ),
            ),
          )
      ],
    );
  }
}
