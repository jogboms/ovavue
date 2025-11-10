import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/screens/budget_plans/providers/selected_budget_plan_provider.dart';
import 'package:ovavue/presentation/screens/budget_plans/utils/delete_budget_plan_action.dart';
import 'package:ovavue/presentation/screens/budget_plans/widgets/budget_category_selection_picker.dart';
import 'package:ovavue/presentation/screens/budget_plans/widgets/budget_metadata_selection_picker.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetPlanDetailPage extends StatefulWidget {
  const BudgetPlanDetailPage({super.key, required this.id, required this.entrypoint, this.budgetId});

  final String id;
  final BudgetPlanDetailPageEntrypoint entrypoint;
  final String? budgetId;

  @override
  State<BudgetPlanDetailPage> createState() => BudgetPlanDetailPageState();
}

@visibleForTesting
class BudgetPlanDetailPageState extends State<BudgetPlanDetailPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref
          .watch(selectedBudgetPlanProvider(id: widget.id, budgetId: widget.budgetId))
          .when(
            data: (BudgetPlanState data) => _ContentDataView(
              key: dataViewKey,
              entrypoint: widget.entrypoint,
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

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({
    super.key,
    required this.entrypoint,
    required this.state,
    required this.budgetId,
  });

  final BudgetPlanDetailPageEntrypoint entrypoint;
  final BudgetPlanState state;
  final String? budgetId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final budget = state.budget;
    final allocation = state.allocation;

    return CustomScrollView(
      slivers: <Widget>[
        const CustomAppBar(title: Text(''), asSliver: true, centerTitle: true),
        SliverList.list(
          children: <Widget>[
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
                        if (entrypoint != BudgetPlanDetailPageEntrypoint.category)
                          _CategoryChip(
                            key: Key(state.plan.category.id),
                            category: state.plan.category,
                            onPressed: () {
                              final budgetId = this.budgetId;
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
                  if (allocation != null && budget != null)
                    AmountRatioItem.large(
                      allocationAmount: allocation.amount,
                      baseAmount: budget.amount,
                    ),
                ],
              ),
            ),
            if (entrypoint != BudgetPlanDetailPageEntrypoint.metadata)
              _MetadataSection(
                metadata: state.metadata,
                onPressed: (BudgetMetadataValueViewModel metadata) => _handleMetadataPressed(
                  context,
                  metadata: metadata,
                ),
              ),
            const SizedBox(height: 2.0),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
                actions: <ActionButton>[
                  if (budget != null && budget.active)
                    ActionButton(
                      icon: AppIcons.modifyAllocation,
                      onPressed: () => _handleAllocationAction(
                        context,
                        ref: ref,
                        budget: budget,
                        plan: state.plan,
                        allocation: allocation,
                      ),
                    ),
                  ActionButton(
                    icon: AppIcons.addCategory,
                    onPressed: () => _handleUpdateCategoryAction(
                      context,
                      ref: ref,
                      plan: state.plan,
                    ),
                  ),
                  ActionButton(
                    icon: AppIcons.metadata,
                    onPressed: () => _handleUpdateMetadataAction(
                      context,
                      ref: ref,
                      plan: state.plan,
                    ),
                  ),
                  ActionButton(
                    icon: AppIcons.edit,
                    onPressed: () => _handleUpdateAction(
                      context,
                      ref: ref,
                      plan: state.plan,
                    ),
                  ),
                  if (budget == null || !budget.active)
                    ActionButton(
                      icon: AppIcons.delete,
                      backgroundColor: colorScheme.surfaceContainerHighest,
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
                      icon: AppIcons.removeAllocation,
                      backgroundColor: colorScheme.surfaceContainerHighest,
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
        SliverPinnedTitleCountHeader.count(
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
            sliver: SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                final (BudgetAllocationViewModel allocation, BudgetViewModel budget) = state.previousAllocations[index];

                return BudgetListTile(
                  key: Key(budget.id),
                  id: budget.id,
                  title: budget.title,
                  budgetAmount: budget.amount,
                  allocationAmount: allocation.amount,
                  active: budget.active,
                  startedAt: budget.startedAt,
                  endedAt: budget.endedAt,
                );
              },
              itemCount: state.previousAllocations.length,
            ),
          ),
      ],
    );
  }

  void _handleMetadataPressed(
    BuildContext context, {
    required BudgetMetadataValueViewModel metadata,
  }) {
    context.router.goToBudgetMetadataDetail(id: metadata.id, budgetId: budgetId);
  }

  void _handleAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetViewModel budget,
    required BudgetPlanViewModel plan,
    required BudgetAllocationViewModel? allocation,
  }) async {
    final result = await showBudgetAllocationEntryForm(
      context: context,
      allocation: allocation?.amount,
      plan: plan,
      budgetId: budget.id,
      plansById: <String>[plan.id],
    );
    if (result == null) {
      return;
    }

    final provider = ref.read(budgetPlanProvider);
    if (allocation == null) {
      await provider.createAllocation(
        CreateBudgetAllocationData(
          amount: result.amount.rawValue,
          budget: (id: budget.id, path: budget.path),
          plan: (id: plan.id, path: plan.path),
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
    final l10n = context.l10n;

    final category = await showModalBottomSheet<BudgetCategoryViewModel>(
      context: context,
      builder: (_) => BudgetCategorySelectionPicker(
        selectedId: plan.category.id,
      ),
    );
    if (category == null) {
      return;
    }
    if (context.mounted) {
      final choice = await showErrorChoiceBanner(
        context,
        message: l10n.updatePlanCategoryAreYouSureAboutThisMessage,
      );
      if (!choice) {
        return;
      }

      await ref.read(budgetPlanProvider).updateCategory(plan: plan, category: category);
    }
  }

  void _handleUpdateMetadataAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanViewModel plan,
  }) async => showModalBottomSheet<void>(
    context: context,
    builder: (_) => BudgetMetadataSelectionPicker(plan: plan),
  );

  void _handleDeleteAllocationAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetAllocationViewModel allocation,
  }) async {
    final l10n = context.l10n;
    final snackBar = context.snackBar;
    final choice = await showErrorChoiceBanner(
      context,
      message: l10n.deleteAllocationAreYouSureAboutThisMessage,
    );
    if (!choice) {
      return;
    }

    final successful = await ref
        .read(budgetPlanProvider)
        .deleteAllocation(
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
    final l10n = context.l10n;
    final snackBar = context.snackBar;

    final result = await showBudgetPlanEntryForm(
      context: context,
      type: BudgetPlanEntryType.update,
      title: plan.title,
      description: plan.description,
      category: plan.category,
    );
    if (result == null) {
      return null;
    }

    final successful = await ref
        .read(budgetPlanProvider)
        .update(
          UpdateBudgetPlanData(
            id: plan.id,
            path: plan.path,
            title: result.title,
            description: result.description,
            category: (id: plan.category.id, path: plan.category.path),
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
    final textTheme = Theme.of(context).textTheme;

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

class _MetadataSection extends StatelessWidget {
  const _MetadataSection({required this.metadata, required this.onPressed});

  final List<BudgetMetadataValueViewModel> metadata;
  final ValueChanged<BudgetMetadataValueViewModel> onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (metadata.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Wrap(
        runSpacing: 4.0,
        spacing: 4.0,
        children: <Widget>[
          for (final BudgetMetadataValueViewModel item in metadata)
            CupertinoButton(
              onPressed: () => onPressed(item),
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
              minimumSize: Size.zero,
              child: Text(
                '#${item.title}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: AppFontWeight.semibold,
                  color: colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
