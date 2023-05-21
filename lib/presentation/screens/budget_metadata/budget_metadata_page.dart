import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../constants.dart';
import '../../models.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';

class BudgetMetadataPage extends StatefulWidget {
  const BudgetMetadataPage({super.key});

  @override
  State<BudgetMetadataPage> createState() => _BudgetMetadataPageState();
}

class _BudgetMetadataPageState extends State<BudgetMetadataPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(budgetMetadataProvider).when(
              data: (List<BudgetMetadataViewModel> data) => _ContentDataView(
                key: dataViewKey,
                data: data,
              ),
              error: ErrorView.new,
              loading: () => child!,
            ),
        child: const LoadingView(),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.data});

  final List<BudgetMetadataViewModel> data;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(l10n.metadataPageTitle),
          asSliver: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, _) => ActionButtonRow(
              alignment: Alignment.center,
              actions: <ActionButton>[
                ActionButton(
                  icon: AppIcons.plus,
                  onPressed: () {},
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
              sliver: _SliverMetadataGroup(
                key: Key(metadata.id),
                metadata: metadata,
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
}

class _SliverMetadataGroup extends StatefulWidget {
  const _SliverMetadataGroup({super.key, required this.metadata});

  final BudgetMetadataViewModel metadata;

  @override
  State<_SliverMetadataGroup> createState() => _SliverMetadataGroupState();
}

class _SliverMetadataGroupState extends State<_SliverMetadataGroup> {
  late bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final List<BudgetMetadataValueViewModel> values = widget.metadata.values;

    return SliverStickyHeader(
      header: Material(
        child: InkWell(
          child: Ink(
            color: colorScheme.surface,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                _Header(
                  key: Key(widget.metadata.id),
                  metadata: widget.metadata,
                ),
                AnimatedRotation(
                  turns: _expanded ? 0 : 0.5,
                  duration: kThemeChangeDuration,
                  child: const Icon(AppIcons.arrowDown),
                ),
              ],
            ),
          ),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
      ),
      sliver: _expanded
          ? SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList.separated(
                itemBuilder: (BuildContext context, int index) {
                  final BudgetMetadataValueViewModel value = values[index];

                  return _MetadataTile(
                    key: Key(value.id),
                    item: value,
                    onPressed: () {},
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemCount: values.length,
              ),
            )
          : const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key, required this.metadata});

  final BudgetMetadataViewModel metadata;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(metadata.title.sentence(), style: textTheme.bodyMedium, maxLines: 1),
          if (metadata.description.isNotEmpty) ...<Widget>[
            const SizedBox(height: 2.0),
            Text(metadata.description, style: textTheme.titleMedium),
          ],
        ],
      ),
    );
  }
}

class _MetadataTile extends StatelessWidget {
  const _MetadataTile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  final BudgetMetadataValueViewModel item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      child: Text('${item.value} | ${item.title}'),
    );
  }
}
