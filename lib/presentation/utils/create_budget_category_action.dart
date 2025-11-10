import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/widgets.dart';

Future<String?> createBudgetCategoryAction({
  required BuildContext context,
  required WidgetRef ref,
  required bool navigateOnComplete,
}) async {
  final router = context.router;

  final result = await showBudgetCategoryEntryForm(
    context: context,
    title: null,
    description: null,
    icon: null,
    colorScheme: null,
  );
  if (result == null) {
    return null;
  }

  final id = await ref
      .read(budgetCategoryProvider)
      .create(
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
