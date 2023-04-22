import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets.dart';
import 'providers/budget_category_state.dart';
import 'providers/selected_budget_category_by_budget_provider.dart';
import 'widgets/budget_category_detail_data_view.dart';

class BudgetCategoryDetailForBudgetPage extends StatefulWidget {
  const BudgetCategoryDetailForBudgetPage({super.key, required this.id, required this.budgetId});

  final String id;
  final String budgetId;

  @override
  State<BudgetCategoryDetailForBudgetPage> createState() => BudgetCategoryDetailForBudgetPageState();
}

@visibleForTesting
class BudgetCategoryDetailForBudgetPageState extends State<BudgetCategoryDetailForBudgetPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetCategoryByBudgetProvider(id: widget.id, budgetId: widget.budgetId)).when(
                  skipLoadingOnRefresh: true,
                  skipLoadingOnReload: true,
                  data: (BudgetCategoryState data) => BudgetCategoryDetailDataView(
                    key: dataViewKey,
                    state: data,
                  ),
                  error: ErrorView.new,
                  loading: () => child!,
                ),
        child: const LoadingView(),
      ),
    );
  }
}
