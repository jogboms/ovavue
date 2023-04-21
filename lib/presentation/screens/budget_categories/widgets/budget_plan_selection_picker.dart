import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../widgets.dart';

class BudgetPlanSelectionPicker extends StatelessWidget {
  const BudgetPlanSelectionPicker({super.key});

  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetPlansProvider).when(
            data: (List<BudgetPlanViewModel> data) => _ContentDataView(
              key: dataViewKey,
              data: data,
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

  final List<BudgetPlanViewModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 24),
      itemBuilder: (BuildContext context, int index) {
        final BudgetPlanViewModel plan = data[index];

        return BudgetPlanListTile(
          key: Key(plan.id),
          plan: plan,
          onTap: () => Navigator.pop(context, plan),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemCount: data.length,
    );
  }
}
