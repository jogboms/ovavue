import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/screens/budget_plans/utils/delete_budget_plan_action.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetPlansPage extends StatefulWidget {
  const BudgetPlansPage({super.key});

  @override
  State<BudgetPlansPage> createState() => BudgetPlansPageState();
}

@visibleForTesting
class BudgetPlansPageState extends State<BudgetPlansPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(budgetPlansProvider)
          .when(
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

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final List<BudgetPlanViewModel> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.plansPageTitle),
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
              sliver: SliverList.separated(
                itemBuilder: (BuildContext context, int index) {
                  final plan = data[index];

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
                          backgroundColor: colorScheme.error,
                          foregroundColor: colorScheme.onError,
                          icon: AppIcons.delete,
                          label: context.l10n.deleteLabel,
                        ),
                      ],
                    ),
                    child: BudgetPlanListTile(
                      plan: plan,
                      onTap: () => context.router.goToBudgetPlanDetail(
                        id: plan.id,
                        entrypoint: BudgetPlanDetailPageEntrypoint.list,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemCount: data.length,
              ),
            ),
          ),
      ],
    );
  }
}
