import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';

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
    final ThemeData theme = Theme.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.budgetsPageTitle),
          backgroundColor: theme.scaffoldBackgroundColor,
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: ActionButtonRow(
            actions: <ActionButton>[
              ActionButton(
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
        ),
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
