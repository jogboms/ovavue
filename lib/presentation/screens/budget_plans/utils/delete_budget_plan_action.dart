import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

void deleteBudgetPlanAction(
  BuildContext context, {
  required WidgetRef ref,
  required BudgetPlanViewModel plan,
  required bool dismissOnComplete,
}) async {
  final L10n l10n = context.l10n;
  final AppSnackBar snackBar = context.snackBar;
  final NavigatorState navigator = Navigator.of(context);
  final bool choice = await showErrorChoiceBanner(
    context,
    message: l10n.deletePlanAreYouSureAboutThisMessage,
  );
  if (!choice) {
    return;
  }

  final bool successful = await ref.read(budgetPlanProvider).delete(
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
