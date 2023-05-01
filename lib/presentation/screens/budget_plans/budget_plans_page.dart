import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'utils/delete_budget_plan_action.dart';

class BudgetPlansPage extends StatefulWidget {
  const BudgetPlansPage({super.key});

  @override
  State<BudgetPlansPage> createState() => BudgetPlansPageState();
}

@visibleForTesting
class BudgetPlansPageState extends State<BudgetPlansPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetPlansProvider).when(
              data: (List<BudgetPlanViewModel> data) => _ContentDataView(
                key: dataViewKey,
                data: data,
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
  const _ContentDataView({super.key, required this.data});

  final List<BudgetPlanViewModel> data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.plansPageTitle),
          backgroundColor: theme.scaffoldBackgroundColor,
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
              alignment: Alignment.center,
              actions: <ActionButton>[
                ActionButton(
                  icon: Icons.add,
                  onPressed: () => createBudgetPlanAction(
                    context: context,
                    ref: ref,
                    navigateOnComplete: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (data.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) => SliverPadding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              sliver: SliverList(
                delegate: SliverSeparatorBuilderDelegate(
                  builder: (BuildContext context, int index) {
                    final BudgetPlanViewModel plan = data[index];

                    return Slidable(
                      key: Key(plan.id),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: <SlidableAction>[
                          SlidableAction(
                            onPressed: (BuildContext context) => deleteBudgetPlanAction(
                              context,
                              ref: ref,
                              plan: plan,
                              dismissOnComplete: false,
                            ),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: context.l10n.deleteLabel,
                          ),
                        ],
                      ),
                      child: BudgetPlanListTile(
                        plan: plan,
                        onTap: () => context.router.goToBudgetPlanDetail(id: plan.id),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  childCount: data.length,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
