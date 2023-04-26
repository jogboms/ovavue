import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/active_budget_provider.dart';
import 'utils/create_budget_action.dart';
import 'widgets/budget_detail_data_view.dart';

class ActiveBudgetPage extends StatefulWidget {
  const ActiveBudgetPage({super.key});

  @override
  State<ActiveBudgetPage> createState() => ActiveBudgetPageState();
}

@visibleForTesting
class ActiveBudgetPageState extends State<ActiveBudgetPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(activeBudgetProvider).when(
              data: (BaseBudgetState state) {
                if (state is BudgetState) {
                  return BudgetDetailDataView(key: dataViewKey, state: state);
                }

                return _EmptyBudgetView(ref: ref);
              },
              error: ErrorView.new,
              loading: () => child!,
              skipLoadingOnReload: true,
            ),
        child: const LoadingView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.menu),
        onPressed: () async {
          late final AppRouter router = context.router;
          final _BottomSheetChoice? result = await showModalBottomSheet<_BottomSheetChoice>(
            context: context,
            builder: (_) => const _BottomSheetOptions(),
          );
          if (result == null) {
            return;
          }

          switch (result) {
            case _BottomSheetChoice.budgets:
              return router.goToBudgets();
            case _BottomSheetChoice.plans:
              return router.goToBudgetPlans();
            case _BottomSheetChoice.categories:
              return router.goToBudgetCategories();
            case _BottomSheetChoice.settings:
              // TODO(Jogboms): Not implemented
              break;
          }
        },
      ),
    );
  }
}

class _EmptyBudgetView extends StatelessWidget {
  const _EmptyBudgetView({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final L10n l10n = context.l10n;

    const Widget spacing = SizedBox(height: 12);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add_circle_outline,
            size: 32,
            color: theme.colorScheme.secondary,
          ),
          spacing,
          Text(
            l10n.letsCreateMessage,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          spacing,
          TextButton(
            onPressed: () => createBudgetAction(context, ref: ref, navigateOnComplete: false),
            child: Text(l10n.getStatedCaption),
          ),
        ],
      ),
    );
  }
}

enum _BottomSheetChoice {
  budgets,
  plans,
  categories,
  settings,
}

class _BottomSheetOptions extends StatelessWidget {
  const _BottomSheetOptions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _BottomSheetChoice choice in _BottomSheetChoice.values)
            ListTile(
              key: Key(choice.name),
              onTap: () => Navigator.of(context).pop(choice),
              title: Text(choice.name.capitalize(), textAlign: TextAlign.center),
            ),
        ],
      ),
    );
  }
}
