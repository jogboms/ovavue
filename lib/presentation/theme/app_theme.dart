import 'package:flutter/material.dart';

import 'app_border_radius.dart';
import 'app_font.dart' if (dart.library.html) 'app_font_web.dart';
import 'app_style.dart';
import 'color_schemes.dart';

const Color _kMutedColor = Color(0xFF616161);
const double _kIconSize = 28.0;

@visibleForTesting
class AppTextTheme {
  const AppTextTheme._();

  final TextStyle button = const TextStyle(
    fontSize: 15.0,
    fontWeight: AppFontWeight.semibold,
    fontFamily: kAppFontFamily,
  );
}

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

  final AppTextTheme text = const AppTextTheme._();
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

  final ColorScheme colorScheme = isDark ? darkColorScheme : lightColorScheme;
  final Color scaffoldBackgroundColor = isDark ? const Color(0xFF010101) : colorScheme.background;

  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: appTheme.textFieldBorderRadius,
  );
  final OutlineInputBorder textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: BorderSide(color: colorScheme.error),
  );

  final TextTheme textTheme = defaultTheme.textTheme.apply(fontFamily: kAppFontFamily);

  final ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(appTheme.text.button),
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

extension ColorSchemeExtensions on ColorScheme {
  Color get inverseBackground => onBackground;

  Color get mutedBackground => Color.lerp(_kMutedColor, background, .85)!;

  Color get onMutedBackground => Color.lerp(_kMutedColor, onBackground, .15)!;
}
