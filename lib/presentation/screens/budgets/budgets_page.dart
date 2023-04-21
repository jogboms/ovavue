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
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

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

                return ListTile(
                  title: Text(budget.title),
                  subtitle: budget.active
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                            margin: const EdgeInsets.only(right: 2),
                            child: Text(
                              context.l10n.activeLabel,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        )
                      : BudgetDurationText.medium(
                          startedAt: budget.startedAt,
                          endedAt: budget.endedAt,
                        ),
                  trailing: Text(
                    budget.amount.formatted,
                    style: textTheme.titleMedium?.copyWith(
                      color: budget.active ? colorScheme.onInverseSurface : null,
                    ),
                  ),
                  selected: budget.active,
                  selectedTileColor: colorScheme.inverseSurface,
                  selectedColor: colorScheme.onInverseSurface,
                  onTap: budget.active ? null : () => context.router.goToBudgetDetail(id: budget.id),
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
