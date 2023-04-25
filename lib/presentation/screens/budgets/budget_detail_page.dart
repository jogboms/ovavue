import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state.dart';
import '../../widgets.dart';
import 'widgets/budget_detail_data_view.dart';

class BudgetDetailPage extends StatefulWidget {
  const BudgetDetailPage({super.key, required this.id});

  final String id;

  @override
  State<BudgetDetailPage> createState() => BudgetDetailPageState();
}

@visibleForTesting
class BudgetDetailPageState extends State<BudgetDetailPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetProvider(widget.id)).when(
                  data: (BudgetState data) => BudgetDetailDataView(
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
