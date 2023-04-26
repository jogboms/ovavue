import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../widgets.dart';

class BudgetCategorySelectionPicker extends StatelessWidget {
  const BudgetCategorySelectionPicker({super.key, required this.selectedId});

  final String selectedId;

  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetCategoriesProvider).when(
            data: (List<BudgetCategoryViewModel> data) => _ContentDataView(
              key: dataViewKey,
              data: data.where((_) => _.id != selectedId),
            ),
            error: ErrorView.new,
            loading: () => child!,
          ),
      child: const LoadingView(),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final Iterable<BudgetCategoryViewModel> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const EmptyView();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemBuilder: (BuildContext context, int index) {
        final BudgetCategoryViewModel category = data.elementAt(index);

        return BudgetCategoryListTile(
          key: Key(category.id),
          category: category,
          onTap: () => Navigator.pop(context, category),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemCount: data.length,
    );
  }
}
