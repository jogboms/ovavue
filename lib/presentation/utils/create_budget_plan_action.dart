import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils/budget_plan_detail_page_entrypoint.dart';
import 'package:ovavue/presentation/widgets.dart';

Future<String?> createBudgetPlanAction({
  required BuildContext context,
  required WidgetRef ref,
  required bool navigateOnComplete,
}) async {
  final router = context.router;

  final result = await showBudgetPlanEntryForm(
    context: context,
    type: BudgetPlanEntryType.create,
    title: null,
    description: null,
    category: null,
  );
  if (result == null) {
    return null;
  }

  final id = await ref
      .read(budgetPlanProvider)
      .create(
        CreateBudgetPlanData(
          title: result.title,
          description: result.description,
          category: (id: result.category.id, path: result.category.path),
        ),
      );
  if (navigateOnComplete) {
    await router.goToBudgetPlanDetail(
      id: id,
      entrypoint: BudgetPlanDetailPageEntrypoint.budget,
    );
  }

  return id;
}
