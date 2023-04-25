import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routing.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../providers/budget_provider.dart';
import '../widgets/budget_entry_form.dart';

void createBudgetAction(
  BuildContext context, {
  required WidgetRef ref,
  required bool navigateOnComplete,
  String? budgetId,
  int? index,
  Money? amount,
  String? description,
  DateTime? createdAt,
}) async {
  final L10n l10n = context.l10n;
  final AppSnackBar snackBar = context.snackBar;
  final AppRouter router = context.router;

  final BudgetEntryResult? result = await showBudgetEntryForm(
    context: context,
    budgetId: budgetId,
    // TODO(jogboms): default index.
    index: index ?? 1,
    amount: amount,
    description: description,
    createdAt: createdAt ?? clock.now(),
  );
  if (result == null) {
    return;
  }

  final String id = await ref.read(budgetProvider).create(
        fromBudgetId: result.fromBudgetId,
        index: result.index,
        title: result.title,
        amount: result.amount.rawValue,
        description: result.description,
        startedAt: result.startedAt,
        active: result.active,
      );
  snackBar.success(l10n.successfulMessage);
  if (navigateOnComplete) {
    router.goToBudgetDetail(id: id).ignore();
  }
}
