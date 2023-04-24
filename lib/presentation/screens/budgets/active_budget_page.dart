import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/active_budget_provider.dart';
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
              data: (BudgetState data) => BudgetDetailDataView(
                key: dataViewKey,
                state: data,
              ),
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
