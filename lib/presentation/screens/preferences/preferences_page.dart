import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

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
              data: (PreferencesState data) => _ContentDataView(key: dataViewKey, state: data),
              error: ErrorView.new,
              loading: () => child!,
            ),
        child: const LoadingView(),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key, required this.state});

  final PreferencesState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(context.l10n.preferencesTitle),
          asSliver: true,
          centerTitle: true,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: <Widget>[
                _DatabaseLocation(
                  key: Key(state.databaseLocation),
                  path: state.databaseLocation,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DatabaseLocation extends StatelessWidget {
  const _DatabaseLocation({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.databaseLocationLabel,
          style: textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Icon(AppIcons.budget),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                path.truncateLeft(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () async {
                final AppSnackBar snackbar = AppSnackBar.of(context);
                await Clipboard.setData(ClipboardData(text: path));
                snackbar.info(l10n.copiedDatabaseLocationMessage);
              },
              icon: const Icon(AppIcons.copyToClipboard),
            ),
            IconButton(
              onPressed: () => Share.shareXFiles(<XFile>[XFile(path)]),
              icon: const Icon(AppIcons.share),
            ),
          ],
        ),
      ],
    );
  }
}

extension on String {
  static const int _maxLength = 40;

  String truncateLeft() => length > _maxLength ? '...${substring(math.max(0, length - _maxLength), length)}' : this;
}
