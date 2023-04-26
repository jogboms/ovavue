import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import '../routing.dart';
import '../state.dart';
import '../widgets.dart';

void createCategoryAction({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final AppRouter router = context.router;

  final BudgetCategoryEntryResult? result = await showBudgetCategoryEntryForm(
    context: context,
    type: BudgetCategoryEntryType.create,
    title: null,
    description: null,
    icon: null,
    colorScheme: null,
  );
  if (result == null) {
    return;
  }

  final String id = await ref.read(budgetCategoryProvider).create(
        CreateBudgetCategoryData(
          title: result.title,
          description: result.description,
          iconIndex: result.icon.index,
          colorSchemeIndex: result.colorScheme.index,
        ),
      );
  router.goToBudgetCategoryDetail(id: id).ignore();
}
