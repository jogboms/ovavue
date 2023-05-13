import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart' as io;

import '../../constants.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'providers/preferences_provider.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(preferencesProvider).when(
              data: (PreferencesState data) => _ContentDataView(
                key: dataViewKey,
                preferences: ref.read(preferencesProvider.notifier),
                state: data,
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
  const _ContentDataView({
    super.key,
    required this.preferences,
    required this.state,
  });

  final Preferences preferences;
  final PreferencesState state;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(l10n.preferencesTitle),
          asSliver: true,
          centerTitle: true,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: <Widget>[
                _Item(
                  key: Key(state.accountKey),
                  leading: AppIcons.accountKey,
                  actions: <_ItemAction>[
                    (AppIcons.copyToClipboard, () => _handleCopyToClipboard(context, state.accountKey)),
                  ],
                  label: l10n.accountKeyLabel,
                  child: Text(state.accountKey, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 16),
                _Item(
                  key: Key(state.databaseLocation),
                  leading: AppIcons.budget,
                  actions: <_ItemAction>[
                    (AppIcons.copyToClipboard, () => _handleCopyToClipboard(context, state.databaseLocation)),
                  ],
                  label: l10n.databaseLocationLabel,
                  child: Text(
                    state.databaseLocation.truncateLeft(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                _Item(
                  actions: <_ItemAction>[
                    (AppIcons.export, _handleDatabaseExport),
                    (AppIcons.import, () => _handleDatabaseImport(context))
                  ],
                  child: Text(l10n.backupRestoreLabel),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleCopyToClipboard(BuildContext context, String value) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = AppSnackBar.of(context);
    await Clipboard.setData(ClipboardData(text: value));
    snackBar.info(l10n.copiedToClipboardMessage);
  }

  void _handleDatabaseImport(BuildContext context) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = AppSnackBar.of(context);

    final bool? successful = await preferences.importDatabase();
    if (successful == true && context.mounted) {
      await showModalBottomSheet<void>(
        context: context,
        isDismissible: false,
        builder: (_) => const _ExitDialog(),
      );
    } else if (successful == false) {
      snackBar.error(l10n.genericErrorMessage);
    }
  }

  void _handleDatabaseExport() => preferences.exportDatabase();
}

typedef _ItemAction = (IconData, VoidCallback);

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    this.leading,
    this.label,
    required this.child,
    required this.actions,
  });

  final IconData? leading;
  final String? label;
  final Widget child;

  final List<_ItemAction> actions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label case final String label?) ...<Widget>[
          Text(label, style: textTheme.labelLarge),
          const SizedBox(height: 2),
        ],
        Container(
          color: theme.colorScheme.surfaceVariant,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: <Widget>[
              if (leading case final IconData leading?) ...<Widget>[
                Icon(leading),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: DefaultTextStyle(
                  style: label == null ? textTheme.labelLarge! : textTheme.bodyMedium!,
                  child: child,
                ),
              ),
              for (final _ItemAction action in actions) ...<Widget>[
                const SizedBox(width: 6),
                IconButton(onPressed: action.$2, icon: Icon(action.$1)),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

class _ExitDialog extends StatelessWidget {
  const _ExitDialog();

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(l10n.exitAppMessage, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 8),
            PrimaryButton(caption: l10n.continueCaption, onPressed: () => io.exit(1)),
          ],
        ),
      ),
    );
  }
}

extension on String {
  static const int _maxLength = 40;

  String truncateLeft() => length > _maxLength ? '...${substring(math.max(0, length - _maxLength), length)}' : this;
}
