import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:ovavue/core.dart';

import 'screens/budgets/active_budget_page.dart';
import 'state.dart';
import 'theme.dart';
import 'utils.dart';
import 'widgets.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.environment,
    this.themeMode,
    this.home,
    this.navigatorObservers,
  });

  final Environment environment;
  final ThemeMode? themeMode;
  final Widget? home;
  final List<NavigatorObserver>? navigatorObservers;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return _Banner(
      key: Key(widget.environment.name),
      visible: !widget.environment.isProduction,
      message: widget.environment.name.toUpperCase(),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          theme: themeBuilder(ThemeData.light()),
          darkTheme: themeBuilder(ThemeData.dark()),
          themeMode: ref.watch(preferencesProvider.select((_) => _.value?.themeMode)) ?? widget.themeMode,
          onGenerateTitle: (BuildContext context) => context.l10n.appName,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            ...L10n.localizationsDelegates,
            _ResetIntlUtilLocaleLocalizationDelegate(),
          ],
          supportedLocales: L10n.supportedLocales,
          builder: (_, Widget? child) => SnackBarProvider(navigatorKey: _navigatorKey, child: child!),
          home: child,
          navigatorObservers: widget.navigatorObservers ?? <NavigatorObserver>[],
        ),
        child: widget.home ?? const ActiveBudgetPage(),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({super.key, required this.visible, required this.message, required this.child});

  final bool visible;
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: <Widget>[
        child,
        CustomPaint(
          painter: BannerPainter(
            message: message,
            textDirection: TextDirection.ltr,
            layoutDirection: TextDirection.ltr,
            location: BannerLocation.topStart,
            color: const Color(0xFFA573E3),
          ),
        ),
      ],
    );
  }
}

// TODO(Jogboms): intl_util generates a delegate that always sets the defaultLocale to a wrong value. This was the way to go until recently.
// This fix basically resets the defaultLocale and uses the one determined by findSystemLocale from intl found in main.dart
// See
// https://github.com/localizely/intl_utils/pull/18
// https://github.com/flutter/website/pull/3013
class _ResetIntlUtilLocaleLocalizationDelegate extends LocalizationsDelegate<void> {
  const _ResetIntlUtilLocaleLocalizationDelegate();

  @override
  Future<void> load(Locale locale) => Future<void>.sync(() => Intl.defaultLocale = null);

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(covariant LocalizationsDelegate<void> old) => false;
}
