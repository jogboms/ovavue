import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';

class BudgetCategoriesPage extends StatefulWidget {
  const BudgetCategoriesPage({super.key});

  @override
  State<BudgetCategoriesPage> createState() => BudgetCategoriesPageState();
}

@visibleForTesting
class BudgetCategoriesPageState extends State<BudgetCategoriesPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetCategoriesProvider).when(
              data: (List<BudgetCategoryViewModel> data) => _ContentDataView(
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

  final List<BudgetCategoryViewModel> data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.categoriesPageTitle),
          backgroundColor: theme.scaffoldBackgroundColor,
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: ActionButtonRow(
            actions: <ActionButton>[
              ActionButton(
                icon: Icons.add_chart,
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
                final BudgetCategoryViewModel category = data[index];

                return ListTile(
                  key: Key(category.id),
                  title: Text(category.title.sentence(), maxLines: 1),
                  titleTextStyle: theme.textTheme.bodyLarge,
                  subtitle: Text(category.description.capitalize(), maxLines: 2),
                  subtitleTextStyle: theme.textTheme.bodyMedium,
                  leading: CircleAvatar(
                    backgroundColor: category.backgroundColor,
                    foregroundColor: category.foregroundColor,
                    child: Icon(category.icon),
                  ),
                  onTap: () => context.router.goToBudgetCategoryDetail(id: category.id),
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
