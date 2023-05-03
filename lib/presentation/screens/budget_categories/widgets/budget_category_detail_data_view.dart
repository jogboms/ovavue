import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import '../../../constants.dart';
import '../../../models.dart';
import '../../../routing.dart';
import '../../../state.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../providers/budget_category_state.dart';
import '../providers/models.dart';
import 'budget_category_header.dart';
import 'budget_category_plan_tile.dart';
import 'budget_plan_selection_picker.dart';

class BudgetCategoryDetailDataView extends StatelessWidget {
  const BudgetCategoryDetailDataView({super.key, required this.state});

  final BudgetCategoryState state;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = state.category.colorScheme.background;
    final Color foregroundColor = state.category.colorScheme.foreground;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          systemOverlayStyle: state.category.colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          leading: BackButton(color: foregroundColor),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                BudgetCategoryHeader(
                  category: state.category,
                  allocationAmount: state.allocation,
                  budgetAmount: state.budget?.amount,
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
                    actions: <ActionButton>[
                      ActionButton(
                        icon: AppIcons.addPlan,
                        backgroundColor: foregroundColor,
                        foregroundColor: backgroundColor,
                        onPressed: () => _handlePlanAdditionAction(
                          context,
                          ref: ref,
                          category: state.category,
                          planIds: state.plans.map((_) => _.id),
                        ),
                      ),
                      ActionButton(
                        icon: AppIcons.edit,
                        backgroundColor: foregroundColor,
                        foregroundColor: backgroundColor,
                        onPressed: () => _handleCategoryUpdateAction(
                          context,
                          ref: ref,
                          category: state.category,
                        ),
                      ),
                      if (state.plans.isEmpty)
                        ActionButton.outline(
                          icon: AppIcons.delete,
                          borderColor: foregroundColor,
                          onPressed: () => _handleCategoryDeletionAction(
                            context,
                            ref: ref,
                            category: state.category,
                            dismissOnComplete: true,
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        SliverPinnedTitleCountHeader(
          title: context.l10n.associatedPlansTitle,
          count: state.plans.length,
        ),
        if (state.plans.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          SliverPadding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            sliver: SliverList(
              delegate: SliverSeparatorBuilderDelegate(
                builder: (BuildContext context, int index) {
                  final BudgetCategoryPlanViewModel plan = state.plans[index];

                  return BudgetCategoryPlanTile(
                    key: Key(plan.id),
                    plan: plan,
                    categoryAllocationAmount: state.allocation,
                    onPressed: () => context.router.goToBudgetPlanDetail(
                      id: plan.id,
                      budgetId: state.budget?.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                childCount: state.plans.length,
              ),
            ),
          ),
      ],
    );
  }

  void _handlePlanAdditionAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetCategoryViewModel category,
    required Iterable<String> planIds,
  }) async {
    final L10n l10n = context.l10n;

    final BudgetPlanViewModel? plan = await showModalBottomSheet(
      context: context,
      builder: (_) => BudgetPlanSelectionPicker(
        selectedIds: planIds,
      ),
    );
    if (plan == null) {
      return;
    }
    if (context.mounted) {
      final bool choice = await showErrorChoiceBanner(
        context,
        message: l10n.updatePlanCategoryAreYouSureAboutThisMessage,
      );
      if (!choice) {
        return;
      }

      await ref.read(budgetPlanProvider).updateCategory(plan: plan, category: category);
    }
  }

  void _handleCategoryDeletionAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetCategoryViewModel category,
    required bool dismissOnComplete,
  }) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = context.snackBar;
    final NavigatorState navigator = Navigator.of(context);
    final bool choice = await showErrorChoiceBanner(
      context,
      message: l10n.deleteCategoryAreYouSureAboutThisMessage,
    );
    if (!choice) {
      return;
    }

    final bool successful = await ref.read(budgetCategoryProvider).delete((id: category.id, path: category.path));
    if (successful) {
      snackBar.success(l10n.successfulMessage);
      if (dismissOnComplete) {
        navigator.pop();
      }
    } else {
      snackBar.error(l10n.genericErrorMessage);
    }
  }

  void _handleCategoryUpdateAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetCategoryViewModel category,
  }) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = context.snackBar;

    final BudgetCategoryEntryResult? result = await showBudgetCategoryEntryForm(
      context: context,
      title: category.title,
      description: category.description,
      icon: category.icon,
      colorScheme: category.colorScheme,
    );
    if (result == null) {
      return;
    }

    final bool successful = await ref.read(budgetCategoryProvider).update(
          UpdateBudgetCategoryData(
            id: category.id,
            path: category.path,
            title: result.title,
            description: result.description,
            iconIndex: result.icon.index,
            colorSchemeIndex: result.colorScheme.index,
          ),
        );
    if (successful) {
      snackBar.success(l10n.successfulMessage);
    } else {
      snackBar.error(l10n.genericErrorMessage);
    }
  }
}
