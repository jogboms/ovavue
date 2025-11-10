import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/screens/budgets/widgets/budget_detail_data_view.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetDetailPage extends StatefulWidget {
  const BudgetDetailPage({super.key, required this.id});

  final String id;

  @override
  State<BudgetDetailPage> createState() => BudgetDetailPageState();
}

@visibleForTesting
class BudgetDetailPageState extends State<BudgetDetailPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(selectedBudgetProvider(widget.id))
          .when(
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
