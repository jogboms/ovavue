import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/budget_category_state.dart';
import 'package:ovavue/presentation/screens/budget_categories/providers/selected_budget_category_provider.dart';
import 'package:ovavue/presentation/screens/budget_categories/widgets/budget_category_detail_data_view.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  const BudgetCategoryDetailPage({super.key, required this.id});

  final String id;

  @override
  State<BudgetCategoryDetailPage> createState() => BudgetCategoryDetailPageState();
}

@visibleForTesting
class BudgetCategoryDetailPageState extends State<BudgetCategoryDetailPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (context, ref, child) => ref
          .watch(selectedBudgetCategoryProvider(widget.id))
          .when(
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
