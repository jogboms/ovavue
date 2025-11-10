import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetCategoriesPage extends StatefulWidget {
  const BudgetCategoriesPage({super.key});

  @override
  State<BudgetCategoriesPage> createState() => BudgetCategoriesPageState();
}

@visibleForTesting
class BudgetCategoriesPageState extends State<BudgetCategoriesPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(budgetCategoriesProvider)
          .when(
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

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final List<BudgetCategoryViewModel> data;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: <Widget>[
      CustomAppBar(
        title: Text(context.l10n.categoriesPageTitle),
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
                onPressed: () => createBudgetCategoryAction(
                  context: context,
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
          sliver: SliverList.separated(
            itemBuilder: (BuildContext context, int index) {
              final category = data[index];

              return BudgetCategoryListTile(
                key: Key(category.id),
                category: category,
                onTap: () => context.router.goToBudgetCategoryDetail(id: category.id),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemCount: data.length,
          ),
        ),
    ],
  );
}
