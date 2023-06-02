import 'package:flutter/material.dart';

import 'app_border_radius.dart';
import 'app_font.dart' if (dart.library.html) 'app_font_web.dart';
import 'app_style.dart';

const Color _kPrimaryLightColor = Color(0xFF006B5A);
const Color _kPrimaryDarkColor = Color(0xFF5BDBBF);
const Color _kBackgroundDarkColor = Color(0xFF010101);
const double _kIconSize = 28.0;

@visibleForTesting
class AppColorTheme {
  const AppColorTheme._();

  final Color success = const Color(0xFF239f77);
  final Color onSuccess = const Color(0xFFFFFFFF);

  final Color danger = const Color(0xFFEB5757);
  final Color onDanger = const Color(0xFFFFFFFF);
}

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme._();

  final AppColorTheme color = const AppColorTheme._();

  final BorderRadius textFieldBorderRadius = AppBorderRadius.c8;

  @override
  ThemeExtension<AppTheme> copyWith() => this;

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) => this;
}

ThemeData themeBuilder(
  ThemeData defaultTheme, {
  AppTheme appTheme = const AppTheme._(),
}) {
  final Brightness brightness = defaultTheme.brightness;
  final bool isDark = brightness == Brightness.dark;

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? _kPrimaryDarkColor : _kPrimaryLightColor,
    brightness: brightness,
  );
  final Color scaffoldBackgroundColor = isDark ? _kBackgroundDarkColor : colorScheme.background;

  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: appTheme.textFieldBorderRadius,
  );
  final OutlineInputBorder textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: BorderSide(color: colorScheme.error),
  );

  final TextTheme textTheme = defaultTheme.textTheme.apply(fontFamily: kAppFontFamily);

  final TextStyle? buttonTextStyle = textTheme.labelMedium?.copyWith(
    fontWeight: AppFontWeight.semibold,
  );
  final ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(0),
  );

  return ThemeData(
    useMaterial3: true,
    iconTheme: defaultTheme.iconTheme.copyWith(size: _kIconSize),
    primaryIconTheme: defaultTheme.primaryIconTheme.copyWith(size: _kIconSize),
    textTheme: defaultTheme.textTheme.merge(textTheme),
    primaryTextTheme: defaultTheme.primaryTextTheme.merge(textTheme),
    shadowColor: colorScheme.scrim,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textButtonTheme: TextButtonThemeData(style: buttonStyle),
    filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: colorScheme.secondaryContainer,
      foregroundColor: colorScheme.onSecondaryContainer,
    ),
    colorScheme: colorScheme,
    inputDecorationTheme: InputDecorationTheme(
      border: textFieldBorder,
      focusedBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      errorBorder: textFieldErrorBorder,
      focusedErrorBorder: textFieldErrorBorder,
      contentPadding: const EdgeInsets.all(12),
      filled: true,
    ),
    fontFamily: kAppFontFamily,
    extensions: <ThemeExtension<dynamic>>{
      appTheme,
    },
  );
}

extension AppThemeThemeDataExtensions on ThemeData {
  AppTheme get appTheme => extension<AppTheme>()!;
}

extension BuildContextThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
}
