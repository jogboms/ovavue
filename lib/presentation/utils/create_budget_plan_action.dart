import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import '../routing.dart';
import '../state.dart';
import '../widgets.dart';

Future<String?> createBudgetPlanAction({
  required BuildContext context,
  required WidgetRef ref,
  required bool navigateOnComplete,
}) async {
  final AppRouter router = context.router;

  final BudgetPlanEntryResult? result = await showBudgetPlanEntryForm(
    context: context,
    type: BudgetPlanEntryType.create,
    title: null,
    description: null,
    category: null,
  );
  if (result == null) {
    return null;
  }

  final String id = await ref.read(budgetPlanProvider).create(
        CreateBudgetPlanData(
          title: result.title,
          description: result.description,
          category: ReferenceEntity(
            id: result.category.id,
            path: result.category.path,
          ),
        ),
      );
  if (navigateOnComplete) {
    await router.goToBudgetPlanDetail(id: id);
  }

  return id;
}
