import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
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
              data: (BaseBudgetState state) => switch (state) {
                BudgetState() => BudgetDetailDataView(key: dataViewKey, state: state),
                EmptyBudgetState() => _EmptyBudgetView(ref: ref),
              },
              error: ErrorView.new,
              loading: () => child!,
              skipLoadingOnReload: true,
            ),
        child: const LoadingView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(AppIcons.menu),
        onPressed: () async {
          late final AppRouter router = context.router;
          final _BottomSheetChoice? result = await showModalBottomSheet<_BottomSheetChoice>(
            context: context,
            builder: (_) => const _BottomSheetOptions(),
          );

          return switch (result) {
            _BottomSheetChoice.budgets => router.goToBudgets(),
            _BottomSheetChoice.plans => router.goToBudgetPlans(),
            _BottomSheetChoice.categories => router.goToBudgetCategories(),
            _BottomSheetChoice.metadata => router.goToBudgetMetadata(),
            _BottomSheetChoice.preferences => router.goToPreferences(),
            null => null,
          };
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
            AppIcons.addBudget,
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
  budgets(AppIcons.budget),
  plans(AppIcons.plans),
  categories(AppIcons.categories),
  metadata(AppIcons.metadata),
  preferences(AppIcons.preferences);

  const _BottomSheetChoice(this._icon);

  final IconData _icon;
}

class _BottomSheetOptions extends StatelessWidget {
  const _BottomSheetOptions();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        8.0,
        12.0,
        8.0,
        MediaQuery.paddingOf(context).bottom + 8.0,
      ),
      child: Row(
        children: <Widget>[
          for (final _BottomSheetChoice choice in _BottomSheetChoice.values)
            Expanded(
              key: Key(choice.name),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(choice),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(choice._icon),
                    const SizedBox(height: 4),
                    Text(
                      choice.name.capitalize(),
                      textAlign: TextAlign.center,
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
