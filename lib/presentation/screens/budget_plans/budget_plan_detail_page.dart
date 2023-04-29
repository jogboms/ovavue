import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';

import '../../models.dart';
import '../../routing.dart';
import '../../state.dart';
import '../../theme.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/selected_budget_plan_provider.dart';
import 'utils/delete_budget_plan_action.dart';
import 'widgets/budget_category_selection_picker.dart';

class BudgetPlanDetailPage extends StatefulWidget {
  const BudgetPlanDetailPage({super.key, required this.id, this.budgetId});

  final String id;
  final String? budgetId;

  @override
  State<BudgetPlanDetailPage> createState() => BudgetPlanDetailPageState();
}

@visibleForTesting
class BudgetPlanDetailPageState extends State<BudgetPlanDetailPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ref.watch(selectedBudgetPlanProvider(id: widget.id, budgetId: widget.budgetId)).when(
                  data: (BudgetPlanState data) => _ContentDataView(
                    key: dataViewKey,
                    state: data,
                    budgetId: widget.budgetId,
                  ),
                  error: ErrorView.new,
                  loading: () => child!,
                  skipLoadingOnReload: true,
                ),
        child: const LoadingView(),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state, required this.budgetId});

  final BudgetPlanState state;
  final String? budgetId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final BudgetViewModel? budget = state.budget;
    final BudgetPlanAllocationViewModel? allocation = state.allocation;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: const Text(''),
          asSliver: true,
          centerTitle: true,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.plan.title.sentence(),
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: AppFontWeight.semibold,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            state.plan.description.capitalize(),
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                          _CategoryChip(
                            key: Key(state.plan.category.id),
                            category: state.plan.category,
                            onPressed: () {
                              final String? budgetId = this.budgetId;
                              if (budgetId != null) {
                                context.router.goToBudgetCategoryDetailForBudget(
                                  id: state.plan.category.id,
                                  budgetId: budgetId,
                                );
                              } else {
                                context.router.goToBudgetCategoryDetail(
                                  id: state.plan.category.id,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    if (allocation != null)
                      AmountRatioItem.large(
                        allocationAmount: allocation.amount,
                        baseAmount: allocation.budget.amount,
                      )
                  ],
                ),
              ),
              const SizedBox(height: 2.0),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
                  actions: <ActionButton>[
                    if (budget != null && budget.active)
                      ActionButton(
                        icon: Icons.attach_money,
                        onPressed: () => _handleAllocationAction(
                          context,
                          ref: ref,
                          budget: budget,
                          plan: state.plan,
                          allocation: allocation,
                        ),
                      ),
                    ActionButton(
                      icon: Icons.add_chart, // TODO(Jogboms): fix icon
                      onPressed: () => _handleUpdateCategoryAction(
                        context,
                        ref: ref,
                        plan: state.plan,
                      ),
                    ),
                    ActionButton(
                      icon: Icons.edit,
                      onPressed: () => _handleUpdateAction(
                        context,
                        ref: ref,
                        plan: state.plan,
                      ),
                    ),
                    if (budget == null || !budget.active)
                      ActionButton(
                        icon: Icons.delete,
                        backgroundColor: colorScheme.surfaceVariant,
                        foregroundColor: colorScheme.onSurfaceVariant,
                        onPressed: () => deleteBudgetPlanAction(
                          context,
                          ref: ref,
                          plan: state.plan,
                          dismissOnComplete: true,
                        ),
                      )
                    else if (allocation != null)
                      ActionButton(
                        icon: Icons.remove_circle_outline_outlined, // TODO(Jogboms): fix icon
                        backgroundColor: colorScheme.surfaceVariant,
                        foregroundColor: colorScheme.onSurfaceVariant,
                        onPressed: () => _handleDeleteAllocationAction(
                          context,
                          ref: ref,
                          allocation: allocation,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
        SliverPinnedTitleCountHeader(
          title: context.l10n.previousAllocationsTitle,
          count: state.previousAllocations.length,
        ),
        if (state.previousAllocations.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          SliverPadding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final BudgetPlanAllocationViewModel allocation = state.previousAllocations[index];
                  final BudgetPlanAllocationBudgetViewModel budget = allocation.budget;

                  return BudgetListTile(
                    key: Key(budget.id),
                    id: budget.id,
                    title: budget.title,
                    budgetAmount: budget.amount,
                    allocationAmount: allocation.amount,
                    startedAt: budget.startedAt,
                    endedAt: budget.endedAt,
                  );
                },
                childCount: state.previousAllocations.length,
              ),
            ),
          ),
      ],
    );
  }

  void _handleAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
    required BudgetPlanViewModel plan,
    required BudgetPlanAllocationViewModel? allocation,
  }) async {
    final BudgetAllocationEntryResult? result = await showBudgetAllocationEntryForm(
      context: context,
      allocation: allocation?.amount,
      plan: plan,
      budgetId: budget.id,
      plansById: budget.plans.map((_) => _.id),
    );
    if (result == null) {
      return;
    }

    final BudgetPlanProvider provider = ref.read(budgetPlanProvider);
    if (allocation == null) {
      await provider.createAllocation(
        CreateBudgetAllocationData(
          amount: result.amount.rawValue,
          budget: ReferenceEntity(id: budget.id, path: budget.path),
          plan: ReferenceEntity(id: plan.id, path: plan.path),
        ),
      );
    } else {
      await provider.updateAllocation(
        UpdateBudgetAllocationData(
          id: allocation.id,
          path: allocation.path,
          amount: result.amount.rawValue,
        ),
      );
    }
  }

  void _handleUpdateCategoryAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanViewModel plan,
  }) async {
    final L10n l10n = context.l10n;

    final BudgetCategoryViewModel? category = await showModalBottomSheet(
      context: context,
      builder: (_) => BudgetCategorySelectionPicker(
        selectedId: plan.category.id,
      ),
    );
    if (category == null) {
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

  void _handleDeleteAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanAllocationViewModel allocation,
  }) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = context.snackBar;
    final bool choice = await showErrorChoiceBanner(
      context,
      message: l10n.deleteAllocationAreYouSureAboutThisMessage,
    );
    if (!choice) {
      return;
    }

    final bool successful = await ref.read(budgetPlanProvider).deleteAllocation(
          id: allocation.id,
          path: allocation.path,
        );
    if (successful) {
      snackBar.success(l10n.successfulMessage);
    } else {
      snackBar.error(l10n.genericErrorMessage);
    }
  }

  void _handleUpdateAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanViewModel plan,
  }) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = context.snackBar;

    final BudgetPlanEntryResult? result = await showBudgetPlanEntryForm(
      context: context,
      type: BudgetPlanEntryType.update,
      title: plan.title,
      description: plan.description,
      category: plan.category,
    );
    if (result == null) {
      return null;
    }

    final bool successful = await ref.read(budgetPlanProvider).update(
          UpdateBudgetPlanData(
            id: plan.id,
            path: plan.path,
            title: result.title,
            description: result.description,
            categoryId: plan.category.id,
            categoryPath: plan.category.path,
          ),
        );
    if (successful) {
      snackBar.success(l10n.successfulMessage);
    } else {
      snackBar.error(l10n.genericErrorMessage);
    }
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({super.key, required this.category, required this.onPressed});

  final BudgetCategoryViewModel category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ActionChip(
      label: Text(category.title.sentence()),
      avatar: Icon(category.icon.data, color: category.colorScheme.foreground, size: 16.0),
      backgroundColor: category.colorScheme.background,
      side: BorderSide.none,
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: category.colorScheme.foreground,
      ),
      onPressed: onPressed,
    );
  }
}
