import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:ovavue/core.dart';
import 'package:registry/registry.dart';

import 'screens/active_budget/active_budget_page.dart';
import 'theme.dart';
import 'utils.dart';
import 'widgets.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.registry,
    this.home,
    this.navigatorObservers,
  });

  final Registry registry;
  final Widget? home;
  final List<NavigatorObserver>? navigatorObservers;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final Environment environment = widget.registry.get();
  late final String bannerMessage = environment.name.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return _Banner(
      key: Key(bannerMessage),
      visible: !environment.isProduction,
      message: bannerMessage,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: themeBuilder(ThemeData.light()),
        darkTheme: themeBuilder(ThemeData.dark()),
        onGenerateTitle: (BuildContext context) => context.l10n.appName,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          ...L10n.localizationsDelegates,
          _ResetIntlUtilLocaleLocalizationDelegate(),
        ],
        supportedLocales: L10n.supportedLocales,
        builder: (_, Widget? child) => SnackBarProvider(navigatorKey: navigatorKey, child: child!),
        home: widget.home ?? const ActiveBudgetPage(),
        navigatorObservers: widget.navigatorObservers ?? <NavigatorObserver>[],
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
