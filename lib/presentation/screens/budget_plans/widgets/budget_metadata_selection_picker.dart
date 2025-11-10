import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class BudgetMetadataSelectionPicker extends StatelessWidget {
  const BudgetMetadataSelectionPicker({super.key, required this.plan});

  final BudgetPlanViewModel plan;

  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetMetadataProvider).when(
            data: (List<BudgetMetadataViewModel> allData) =>
                ref.watch(selectedBudgetMetadataByPlanProvider(id: plan.id)).when(
                      data: (List<BudgetMetadataValueViewModel> selectedData) => _ContentDataView(
                        key: dataViewKey,
                        allData: allData,
                        selectedData: selectedData,
                        plan: plan,
                      ),
                      error: ErrorView.new,
                      loading: () => child!,
                    ),
            error: ErrorView.new,
            loading: () => child!,
          ),
      child: const LoadingView(),
    );
  }
}

class _ContentDataView extends StatefulWidget {
  const _ContentDataView({
    super.key,
    required this.allData,
    required this.selectedData,
    required this.plan,
  });

  final Iterable<BudgetMetadataViewModel> allData;
  final Iterable<BudgetMetadataValueViewModel> selectedData;
  final BudgetPlanViewModel plan;

  @override
  State<_ContentDataView> createState() => _ContentDataViewState();
}

class _ContentDataViewState extends State<_ContentDataView> {
  static final GlobalKey<FormFieldState<String>> _metadataFieldKey = GlobalKey(debugLabel: 'metadataFieldKey');

  final ValueNotifier<BudgetMetadataViewModel?> _selectedMetadata = ValueNotifier<BudgetMetadataViewModel?>(null);
  final ValueNotifier<BudgetMetadataValueViewModel?> _selectedMetadataValue =
      ValueNotifier<BudgetMetadataValueViewModel?>(null);

  @override
  void dispose() {
    _selectedMetadata.dispose();
    _selectedMetadataValue.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allData.isEmpty) {
      return const EmptyView();
    }

    final L10n l10n = context.l10n;
    final Iterable<String> selectedIds = widget.selectedData.map((_) => _.key.id);
    final Iterable<BudgetMetadataViewModel> keys = widget.allData.where((_) => !selectedIds.contains(_.key.id));

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        24,
        16,
        MediaQuery.paddingOf(context).bottom + 16.0,
      ),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: AnimatedCrossFade(
                duration: kThemeChangeDuration,
                crossFadeState: widget.selectedData.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                firstChild: const EmptyView(),
                secondChild: Wrap(
                  spacing: 8,
                  children: <Widget>[
                    for (final BudgetMetadataValueViewModel metadata in widget.selectedData)
                      Chip(
                        key: Key(metadata.id),
                        label: Text(metadata.title),
                        onDeleted: () => _handleRemoveMetadataAction(
                          context,
                          ref: ref,
                          plan: widget.plan,
                          metadata: metadata,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (keys.isNotEmpty) ...<Widget>[
              ValueListenableBuilder<BudgetMetadataViewModel?>(
                valueListenable: _selectedMetadata,
                builder: (BuildContext context, BudgetMetadataViewModel? value, _) {
                  return DropdownButtonFormField<BudgetMetadataViewModel>(
                    key: _metadataFieldKey,
                    initialValue: value,
                    isExpanded: true,
                    decoration: const InputDecoration(prefixIcon: Icon(AppIcons.metadata)),
                    hint: Text(context.l10n.selectMetadataCaption, overflow: TextOverflow.ellipsis),
                    items: <DropdownMenuItem<BudgetMetadataViewModel>>[
                      for (final BudgetMetadataViewModel item in keys)
                        DropdownMenuItem<BudgetMetadataViewModel>(
                          key: Key(item.key.id),
                          value: item,
                          child: Text(item.key.title),
                        ),
                    ],
                    onChanged: (BudgetMetadataViewModel? value) {
                      _selectedMetadata.value = value;
                      _selectedMetadataValue.value = null;
                    },
                  );
                },
              ),
              ValueListenableBuilder<BudgetMetadataViewModel?>(
                valueListenable: _selectedMetadata,
                builder: (BuildContext context, BudgetMetadataViewModel? metadata, _) {
                  if (metadata == null) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      DropdownButtonFormField<BudgetMetadataValueViewModel>(
                        key: Key(metadata.key.id),
                        initialValue: _selectedMetadataValue.value,
                        isExpanded: true,
                        hint: Text(context.l10n.selectMetadataValueCaption, overflow: TextOverflow.ellipsis),
                        items: <DropdownMenuItem<BudgetMetadataValueViewModel>>[
                          for (final BudgetMetadataValueViewModel item in metadata.values)
                            DropdownMenuItem<BudgetMetadataValueViewModel>(
                              key: Key(item.id),
                              value: item,
                              child: Text(item.title),
                            ),
                        ],
                        onChanged: (BudgetMetadataValueViewModel? value) => _selectedMetadataValue.value = value,
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<BudgetMetadataValueViewModel?>(
                        valueListenable: _selectedMetadataValue,
                        builder: (BuildContext context, BudgetMetadataValueViewModel? metadata, _) => PrimaryButton(
                          enabled: metadata != null,
                          caption: l10n.submitCaption,
                          onPressed: () {
                            if (metadata != null) {
                              _handleAddMetadataAction(
                                context,
                                ref: ref,
                                plan: widget.plan,
                                metadata: metadata,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleAddMetadataAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanViewModel plan,
    required BudgetMetadataValueViewModel metadata,
  }) async {
    await ref.read(budgetMetadataProvider.notifier).addMetadataToPlan(
      plan: (id: plan.id, path: plan.path),
      metadata: (id: metadata.id, path: metadata.path),
    );
    _metadataFieldKey.currentState?.reset();
    _selectedMetadata.value = null;
    _selectedMetadataValue.value = null;
  }

  void _handleRemoveMetadataAction(
    BuildContext context, {
    required WidgetRef ref,
    required BudgetPlanViewModel plan,
    required BudgetMetadataValueViewModel metadata,
  }) async {
    await ref.read(budgetMetadataProvider.notifier).removeMetadataFromPlan(
      plan: (id: plan.id, path: plan.path),
      metadata: (id: metadata.id, path: metadata.path),
    );
  }
}
