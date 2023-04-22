import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';

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
            delegate: SliverSeparatorBuilderDelegate(
              builder: (BuildContext context, int index) {
                final BudgetPlanViewModel plan = data[index];

                return BudgetPlanListTile(
                  key: Key(plan.id),
                  plan: plan,
                  onTap: () => context.router.goToBudgetPlanDetail(id: plan.id),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              childCount: data.length,
            ),
          ),
        ),
      ],
    );
  }
}
