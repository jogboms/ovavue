import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import '../routing.dart';
import '../state.dart';
import '../widgets.dart';

Future<String?> createBudgetCategoryAction({
  required BuildContext context,
  required WidgetRef ref,
  required bool navigateOnComplete,
}) async {
  final AppRouter router = context.router;

  final BudgetCategoryEntryResult? result = await showBudgetCategoryEntryForm(
    context: context,
    title: null,
    description: null,
    icon: null,
    colorScheme: null,
  );
  if (result == null) {
    return null;
  }

  final String id = await ref.read(budgetCategoryProvider).create(
        CreateBudgetCategoryData(
          title: result.title,
          description: result.description,
          iconIndex: result.icon.index,
          colorSchemeIndex: result.colorScheme.index,
        ),
      );
  if (navigateOnComplete) {
    await router.goToBudgetCategoryDetail(id: id);
  }

  return id;
}
