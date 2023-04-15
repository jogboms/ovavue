import 'package:flutter/material.dart';

import 'app_border_radius.dart';
import 'app_font.dart' if (dart.library.html) 'app_font_web.dart';
import 'app_style.dart';

const MaterialColor _kHintColor = Colors.grey;
const Color _kErrorColor = Color(0xFFEB5757);
const Color _kLightHintColor = Color(0xFFF5F5F5);
const Color _kDarkHintColor = Color(0xFF616161);
const Color _kBorderSideColor = Color(0x66D1D1D1);
const Color _kBorderSideErrorColor = _kErrorColor;
const MaterialColor _kWhiteColor = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    100: Color(0xFFFFFFFF),
    500: Color(0xFFe5e5e5),
    900: Color(0xFFa0a0a0),
  },
);
const double _kIconSize = 28.0;

@visibleForTesting
class AppTextTheme {
  const AppTextTheme._();

  final TextStyle body = const TextStyle(fontSize: 14.0, fontWeight: AppFontWeight.regular);
  final TextStyle button = const TextStyle(fontSize: 15.0, fontWeight: AppFontWeight.semibold);

  final TextStyle textfield = const TextStyle(fontSize: 14.0);
  final TextStyle textfieldLabel = const TextStyle(fontSize: 14.0, color: _kHintColor);
  final TextStyle textfieldHint = const TextStyle(fontSize: 14.0, color: _kHintColor);
  final TextStyle error = const TextStyle(fontSize: 12.0, color: _kBorderSideErrorColor);
}

@visibleForTesting
class AppColorTheme {
  const AppColorTheme._();

  final MaterialColor primaryColor = Colors.indigo;
  final MaterialColor hintColor = _kHintColor;
  final Color errorColor = _kErrorColor;

  final Color splashBackgroundColor = const Color(0xFF100F1E);

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
  final Color backgroundColor = isDark ? appTheme.color.splashBackgroundColor : _kWhiteColor;
  final MaterialColor primaryColor = appTheme.color.primaryColor;

  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: appTheme.textFieldBorderRadius,
  );
  final OutlineInputBorder textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: const BorderSide(color: _kBorderSideErrorColor),
  );

  final TextTheme textTheme = defaultTheme.textTheme
      .merge(
        TextTheme(labelLarge: appTheme.text.button),
      )
      .apply(fontFamily: kAppFontFamily);

  final ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(textTheme.labelLarge),
    elevation: MaterialStateProperty.all(0),
  );

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: primaryColor,
    surface: backgroundColor,
    primary: primaryColor,
    onPrimary: _kWhiteColor,
    background: backgroundColor,
    error: appTheme.color.errorColor,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor.shade700,
    primaryColorLight: primaryColor.shade100,
    iconTheme: defaultTheme.iconTheme.copyWith(size: _kIconSize),
    primaryIconTheme: defaultTheme.primaryIconTheme.copyWith(size: _kIconSize),
    textTheme: defaultTheme.textTheme.merge(textTheme),
    primaryTextTheme: defaultTheme.primaryTextTheme.merge(textTheme),
    canvasColor: colorScheme.surface,
    cardColor: colorScheme.surface,
    scaffoldBackgroundColor: colorScheme.mutedBackground,
    shadowColor: Colors.black12,
    textButtonTheme: TextButtonThemeData(style: buttonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    colorScheme: colorScheme,
    inputDecorationTheme: InputDecorationTheme(
      border: textFieldBorder,
      focusedBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      errorBorder: textFieldErrorBorder,
      focusedErrorBorder: textFieldErrorBorder,
      hintStyle: appTheme.text.textfieldHint,
      labelStyle: appTheme.text.textfieldLabel,
      contentPadding: const EdgeInsets.all(12),
      fillColor: isDark ? backgroundColor : _kLightHintColor,
      filled: true,
      errorStyle: appTheme.text.error,
    ),
    dialogBackgroundColor: colorScheme.surface,
    textSelectionTheme: defaultTheme.textSelectionTheme.copyWith(
      cursorColor: primaryColor,
      selectionColor: primaryColor.shade100.withOpacity(.25),
      selectionHandleColor: primaryColor,
    ),
    fontFamily: kAppFontFamily,
    hintColor: appTheme.color.hintColor,
    disabledColor: appTheme.color.hintColor,
    dividerColor: _kBorderSideColor,
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

  Color get mutedBackground => Color.lerp(_kDarkHintColor, background, .85)!;

  Color get onMutedBackground => Color.lerp(_kDarkHintColor, onBackground, .15)!;
}
