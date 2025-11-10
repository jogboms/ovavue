import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetCategorySelectionPicker extends StatelessWidget {
  const BudgetCategorySelectionPicker({super.key, required this.selectedId});

  final String selectedId;

  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, child) => ref
        .watch(budgetCategoriesProvider)
        .when(
          data: (List<BudgetCategoryViewModel> data) => _ContentDataView(
            key: dataViewKey,
            data: data.where((BudgetCategoryViewModel e) => e.id != selectedId),
          ),
          error: ErrorView.new,
          loading: () => child!,
        ),
    child: const LoadingView(),
  );
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
      itemBuilder: (context, int index) {
        final category = data.elementAt(index);

        return BudgetCategoryListTile(
          key: Key(category.id),
          category: category,
          onTap: () => Navigator.pop(context, category),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemCount: data.length,
    );
  }
}
