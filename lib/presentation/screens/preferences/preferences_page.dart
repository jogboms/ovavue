import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/core.dart';
import 'package:universal_io/io.dart' as io;
import 'package:url_launcher/url_launcher.dart';

import '../../backup_client/backup_client.dart';
import '../../backup_client/backup_client_provider.dart';
import '../../constants.dart';
import '../../state.dart';
import '../../utils.dart';
import '../../widgets.dart';

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
    final L10n l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(l10n.preferencesPageTitle),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(preferencesProvider).when(
              data: (PreferencesState data) => _ContentDataView(
                key: dataViewKey,
                backupClientController: ref.read(backupClientControllerProvider),
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
    required this.backupClientController,
    required this.preferences,
    required this.state,
  });

  final BackupClientController backupClientController;
  final Preferences preferences;
  final PreferencesState state;

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                  key: Key(state.themeMode.name),
                  leading: AppIcons.themeMode,
                  actions: <_ItemAction>[
                    (AppIcons.edit, () => _handleThemeModeUpdate(context, state.themeMode)),
                  ],
                  label: l10n.themeModeLabel,
                  child: Text(state.themeMode.name.capitalize()),
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) => Column(
                    children: <Widget>[
                      _Item(
                        label: l10n.backupClientProviderLabel,
                        child: DropdownButtonFormField<BackupClient>(
                          value: backupClientController.client,
                          isExpanded: true,
                          hint: Text(l10n.selectMetadataCaption, overflow: TextOverflow.ellipsis),
                          items: <DropdownMenuItem<BackupClient>>[
                            for (final BackupClient client in backupClientController.clients)
                              DropdownMenuItem<BackupClient>(
                                key: ObjectKey(client),
                                value: client,
                                child: Text(backupClientController.displayName(client)),
                              ),
                          ],
                          onChanged: (BackupClient? client) {
                            if (client != null) {
                              _handleDatabaseBackupClientSetup(context, client);
                            }
                          },
                        ),
                      ),
                      const Divider(height: 2),
                      _Item(
                        child: Row(
                          children: <Widget>[
                            TextButton(
                              onPressed: () => _handleDatabaseImport(context),
                              child: Text(l10n.backupClientImportLabel),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => _handleDatabaseExport(context),
                              child: Text(l10n.backupClientExportLabel),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _Item(
                  label: l10n.featureRequestsLabel,
                  child: Wrap(
                    spacing: 8,
                    children: <Widget>[
                      TextButton(
                        onPressed: _handleTranslationRequest,
                        child: Text(l10n.translationFeatureRequestCaption),
                      ),
                      TextButton(
                        onPressed: _handleCurrencyRequest,
                        child: Text(l10n.currencyFeatureRequestCaption),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _Item(
                  label: l10n.getInTouchLabel,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(onPressed: _handleSendEmail, icon: const Icon(AppIcons.email)),
                      IconButton(onPressed: _handleOpenTwitter, icon: const Icon(AppIcons.twitter)),
                      IconButton(onPressed: _handleOpenGithubIssue, icon: const Icon(AppIcons.github)),
                      IconButton(onPressed: _handleOpenWebsite, icon: const Icon(AppIcons.website)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, _) => SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'v${ref.watch(appVersionProvider)}',
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
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

  void _handleThemeModeUpdate(BuildContext context, ThemeMode value) async {
    final ThemeMode? themeMode = await showModalBottomSheet<ThemeMode>(
      context: context,
      builder: (_) => _BottomSheetOptions(initialValue: value),
    );
    if (themeMode != null && context.mounted) {
      await preferences.updateThemeMode(themeMode);
    }
  }

  void _handleDatabaseBackupClientSetup(BuildContext context, BackupClient client) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = AppSnackBar.of(context);

    final BackupClientResult result = await backupClientController.setup(client, state.accountKey);
    return switch (result) {
      BackupClientResult.success => snackBar.success(l10n.successfulMessage),
      BackupClientResult.failure => snackBar.error(l10n.genericErrorMessage),
      BackupClientResult.unavailable => snackBar.info(l10n.genericUnavailableMessage),
      BackupClientResult.dismissed => null,
    };
  }

  void _handleDatabaseImport(BuildContext context) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = AppSnackBar.of(context);

    final BackupClientResult result = await backupClientController.import();
    switch (result) {
      case BackupClientResult.success:
        if (context.mounted) {
          await showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            builder: (_) => const _ExitDialog(),
          );
        }
      case BackupClientResult.failure:
        snackBar.error(l10n.genericErrorMessage);
      case BackupClientResult.unavailable:
        snackBar.info(l10n.genericUnavailableMessage);
      case BackupClientResult.dismissed:
    }
  }

  void _handleDatabaseExport(BuildContext context) async {
    final L10n l10n = context.l10n;
    final AppSnackBar snackBar = AppSnackBar.of(context);

    final BackupClientResult result = await backupClientController.export();
    return switch (result) {
      BackupClientResult.success => snackBar.success(l10n.successfulMessage),
      BackupClientResult.failure => snackBar.error(l10n.genericErrorMessage),
      BackupClientResult.unavailable => snackBar.info(l10n.genericUnavailableMessage),
      BackupClientResult.dismissed => null,
    };
  }

  void _handleSendEmail({String subject = 'Hello from Ovavue', String? body}) => _handleOpenUrl(
        Uri(
          scheme: 'mailto',
          path: 'jeremiahogbomo@gmail.com',
          query: <String, String>{
            'subject': subject,
            if (body != null) 'body': body,
          }.entries.map((_) => '${Uri.encodeComponent(_.key)}=${Uri.encodeComponent(_.value)}').join('&'),
        ),
      );

  void _handleOpenTwitter() => _handleOpenUrl(Uri.https('twitter.com', 'jogboms'));

  void _handleOpenGithubIssue() => _handleOpenUrl(Uri.https('github.com', 'jogboms/ovavue/issues/new'));

  void _handleOpenWebsite() => _handleOpenUrl(Uri.https('jogboms.github.io'));

  void _handleTranslationRequest() => _handleSendEmail(
        subject: 'Translation request for Ovavue',
        body: 'I would like to be able to use the application in my local language. My language is ',
      );

  void _handleCurrencyRequest() => _handleSendEmail(
        subject: 'Currency request for Ovavue',
        body: 'I would like to be able to use the application in my local currency. My currency is ',
      );

  void _handleOpenUrl(Uri url) async {
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } on PlatformException catch (e, stackTrace) {
      AppLog.e(AppException(e.message ?? '$e'), stackTrace);
    }
  }
}

typedef _ItemAction = (IconData, VoidCallback);

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    this.leading,
    this.label,
    this.actions,
    required this.child,
  });

  final IconData? leading;
  final String? label;
  final List<_ItemAction>? actions;
  final Widget child;

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
          const SizedBox(height: 4),
        ],
        Container(
          color: theme.colorScheme.surfaceContainerHighest,
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
              if (actions case final List<_ItemAction> actions)
                for (final _ItemAction action in actions) ...<Widget>[
                  const SizedBox(width: 6),
                  IconButton(onPressed: action.$2, icon: Icon(action.$1)),
                ],
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

class _BottomSheetOptions extends StatelessWidget {
  const _BottomSheetOptions({
    required this.initialValue,
  });

  final ThemeMode initialValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final Color activeColor = colorScheme.primary;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        8.0,
        12.0,
        8.0,
        MediaQuery.paddingOf(context).bottom + 8.0,
      ),
      child: Row(
        children: <Widget>[
          for (final ThemeMode choice in ThemeMode.values)
            Expanded(
              key: Key(choice.name),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(choice),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      choice.icon,
                      color: choice == initialValue ? activeColor : colorScheme.onSurface,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      choice.name.capitalize(),
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: choice == initialValue ? activeColor : colorScheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

extension on ThemeMode {
  IconData get icon => switch (this) {
        ThemeMode.system => AppIcons.autoThemeMode,
        ThemeMode.dark => AppIcons.darkThemeMode,
        ThemeMode.light => AppIcons.lightThemeMode,
      };
}
