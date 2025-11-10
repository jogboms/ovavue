import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/routing.dart';
import 'package:ovavue/presentation/screens/budget_metadata/widgets/budget_metadata_entry_form.dart';
import 'package:ovavue/presentation/screens/budget_metadata/widgets/budget_metadata_value_vertical_divider.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

class BudgetMetadataPage extends StatefulWidget {
  const BudgetMetadataPage({super.key});

  @override
  State<BudgetMetadataPage> createState() => _BudgetMetadataPageState();
}

class _BudgetMetadataPageState extends State<BudgetMetadataPage> {
  @visibleForTesting
  static const dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Consumer(
      builder: (context, ref, child) => ref
          .watch(budgetMetadataProvider)
          .when(
            data: (List<BudgetMetadataViewModel> data) => _ContentDataView(
              key: dataViewKey,
              data: data,
              metadataNotifier: ref.read(budgetMetadataProvider.notifier),
            ),
            error: ErrorView.new,
            loading: () => child!,
          ),
      child: const LoadingView(),
    ),
  );
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({
    super.key,
    required this.data,
    required this.metadataNotifier,
  });

  final List<BudgetMetadataViewModel> data;
  final BudgetMetadata metadataNotifier;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: Text(l10n.metadataPageTitle),
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Consumer(
            builder: (context, ref, _) => ActionButtonRow(
              alignment: Alignment.center,
              actions: [
                ActionButton(
                  icon: AppIcons.plus,
                  onPressed: () => _handleModifyMetadata(context, metadata: null),
                ),
              ],
            ),
          ),
        ),
        if (data.isEmpty)
          const SliverFillRemaining(child: EmptyView())
        else
          for (final BudgetMetadataViewModel metadata in data)
            SliverPadding(
              padding: const EdgeInsets.only(top: 4),
              sliver: SliverExpandableGroup<BudgetMetadataValueViewModel>(
                key: Key(metadata.key.id),
                header: _Header(title: metadata.key.title, description: metadata.key.description),
                values: metadata.values,
                itemBuilder: (BudgetMetadataValueViewModel value) => _MetadataValueTile(
                  key: Key(value.id),
                  item: value,
                  onPressed: () => context.router.goToBudgetMetadataDetail(id: value.id),
                ),
                bottom: Center(
                  child: TextButton(
                    onPressed: () => _handleModifyMetadata(context, metadata: metadata),
                    child: Text(l10n.modifyCaption),
                  ),
                ),
              ),
            ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.paddingOf(context).bottom,
          ),
        ),
      ],
    );
  }

  void _handleModifyMetadata(
    BuildContext context, {
    required BudgetMetadataViewModel? metadata,
  }) async {
    final result = await showBudgetMetadataEntryForm(
      context: context,
      type: metadata == null ? BudgetMetadataEntryType.create : BudgetMetadataEntryType.update,
      title: metadata?.key.title,
      description: metadata?.key.description,
      values: metadata?.values,
    );
    if (result == null) {
      return;
    }
    if (context.mounted) {
      final operations = <BudgetMetadataValueOperation>{
        for (final BudgetMetadataValueEntryResult item in result.values)
          switch (item) {
            BudgetMetadataValueEntryModifyResult(reference: final ReferenceEntity reference) =>
              BudgetMetadataValueModificationOperation(
                reference: reference,
                title: item.title,
                value: item.value,
              ),
            BudgetMetadataValueEntryModifyResult() => BudgetMetadataValueCreationOperation(
              title: item.title,
              value: item.value,
            ),
            BudgetMetadataValueEntryRemoveResult() => BudgetMetadataValueRemovalOperation(
              reference: item.reference,
            ),
          },
      };
      if (metadata != null) {
        await metadataNotifier.updateMetadata(
          id: metadata.key.id,
          path: metadata.key.path,
          title: result.title,
          description: result.description,
          operations: operations,
        );
      } else {
        await metadataNotifier.createMetadata(
          title: result.title,
          description: result.description,
          operations: operations,
        );
      }
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.sentence(), style: textTheme.titleMedium, maxLines: 1),
        if (description.isNotEmpty) ...[
          const SizedBox(height: 2.0),
          Text(description.capitalize(), style: textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class _MetadataValueTile extends StatelessWidget {
  const _MetadataValueTile({super.key, required this.item, required this.onPressed});

  final BudgetMetadataValueViewModel item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.title.sentence(),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            ),
            const BudgetMetadataValueVerticalDivider(),
            Expanded(
              child: Text(
                item.value.capitalize(),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: AppFontWeight.semibold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
