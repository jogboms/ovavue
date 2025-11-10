import 'package:flutter/material.dart';
import 'package:ovavue/presentation/theme/app_border_radius.dart';
import 'package:ovavue/presentation/theme/app_font.dart' if (dart.library.html) 'app_font_web.dart';
import 'package:ovavue/presentation/theme/app_style.dart';

const _kPrimaryLightColor = Color(0xFF006B5A);
const _kPrimaryDarkColor = Color(0xFF5BDBBF);
const _kBackgroundDarkColor = Color(0xFF010101);
const _kIconSize = 28.0;

@visibleForTesting
class AppColorTheme {
  const AppColorTheme._();

  Color get success => const Color(0xFF239f77);

  Color get onSuccess => const Color(0xFFFFFFFF);

  Color get danger => const Color(0xFFEB5757);

  Color get onDanger => const Color(0xFFFFFFFF);
}

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme._();

  AppColorTheme get color => const AppColorTheme._();

  BorderRadius get textFieldBorderRadius => AppBorderRadius.c8;

  @override
  ThemeExtension<AppTheme> copyWith() => this;

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) => this;
}

ThemeData themeBuilder(
  ThemeData defaultTheme, {
  AppTheme appTheme = const AppTheme._(),
}) {
  final brightness = defaultTheme.brightness;
  final isDark = brightness == Brightness.dark;

  final colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? _kPrimaryDarkColor : _kPrimaryLightColor,
    brightness: brightness,
  );
  final scaffoldBackgroundColor = isDark ? _kBackgroundDarkColor : colorScheme.surface;

  final textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: appTheme.textFieldBorderRadius,
  );
  final textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: BorderSide(color: colorScheme.error),
  );

  final textTheme = defaultTheme.textTheme.apply(fontFamily: kAppFontFamily);

  final buttonTextStyle = textTheme.labelMedium?.copyWith(
    fontWeight: AppFontWeight.semibold,
  );
  final buttonStyle = ButtonStyle(
    textStyle: WidgetStateProperty.all(buttonTextStyle),
    elevation: WidgetStateProperty.all(0),
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
