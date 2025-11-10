import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetPlanSelectionPicker extends StatelessWidget {
  const BudgetPlanSelectionPicker({super.key, required this.selectedIds});

  final Iterable<String> selectedIds;

  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
        .watch(budgetPlansProvider)
        .when(
          data: (List<BudgetPlanViewModel> data) => _ContentDataView(
            key: dataViewKey,
            data: data.where((BudgetPlanViewModel e) => !selectedIds.contains(e.id)),
          ),
          error: ErrorView.new,
          loading: () => child!,
        ),
    child: const LoadingView(),
  );
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final Iterable<BudgetPlanViewModel> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const EmptyView();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemBuilder: (BuildContext context, int index) {
        final plan = data.elementAt(index);

        return BudgetPlanListTile(
          key: Key(plan.id),
          plan: plan,
          onTap: () => Navigator.pop(context, plan),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 4),
      itemCount: data.length,
    );
  }
}
