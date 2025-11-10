import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

void deleteBudgetPlanAction(
  BuildContext context, {
  required WidgetRef ref,
  required BudgetPlanViewModel plan,
  required bool dismissOnComplete,
}) async {
  final l10n = context.l10n;
  final snackBar = context.snackBar;
  final navigator = Navigator.of(context);
  final choice = await showErrorChoiceBanner(
    context,
    message: l10n.deletePlanAreYouSureAboutThisMessage,
  );
  if (!choice) {
    return;
  }

  final successful = await ref
      .read(budgetPlanProvider)
      .delete(
        id: plan.id,
        path: plan.path,
      );
  if (successful) {
    snackBar.success(l10n.successfulMessage);
    if (dismissOnComplete) {
      navigator.pop();
    }
  } else {
    snackBar.error(l10n.genericErrorMessage);
  }
}
