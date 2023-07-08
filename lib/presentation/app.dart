import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    required this.navigatorKey,
    this.themeMode,
    this.home,
    this.navigatorObservers,
  });

  final Environment environment;
  final GlobalKey<NavigatorState> navigatorKey;
  final ThemeMode? themeMode;
  final Widget? home;
  final List<NavigatorObserver>? navigatorObservers;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return _Banner(
      key: ObjectKey(widget.environment),
      visible: !widget.environment.isProduction,
      message: widget.environment.name.toUpperCase(),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: widget.navigatorKey,
          theme: themeBuilder(ThemeData.light()),
          darkTheme: themeBuilder(ThemeData.dark()),
          themeMode: ref.watch(preferencesProvider.select((_) => _.value?.themeMode)) ?? widget.themeMode,
          onGenerateTitle: (BuildContext context) => context.l10n.appName,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          builder: (_, Widget? child) => SnackBarProvider(navigatorKey: widget.navigatorKey, child: child!),
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
