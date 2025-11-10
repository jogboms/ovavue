import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/screens/budgets/utils/create_budget_action.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  BudgetsPageState createState() => BudgetsPageState();
}

@visibleForTesting
class BudgetsPageState extends State<BudgetsPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(budgetsProvider)
          .when(
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

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final List<BudgetViewModel> data;

  @override
  Widget build(BuildContext context) => CustomScrollView(
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
          sliver: SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              final budget = data[index];

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
            itemCount: data.length,
          ),
        ),
    ],
  );
}
