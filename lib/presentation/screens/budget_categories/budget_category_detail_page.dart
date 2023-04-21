import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets.dart';
import 'providers/budget_category_state.dart';
import 'providers/selected_budget_category_provider.dart';
import 'widgets/budget_category_detail_data_view.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  const BudgetCategoryDetailPage({super.key, required this.id});

  final String id;

  @override
  State<BudgetCategoryDetailPage> createState() => BudgetCategoryDetailPageState();
}

@visibleForTesting
class BudgetCategoryDetailPageState extends State<BudgetCategoryDetailPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetCategoryProvider(widget.id)).when(
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
