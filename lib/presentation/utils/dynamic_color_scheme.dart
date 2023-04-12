import 'package:flutter/material.dart' show ThemeData, Color, Brightness, Colors;

class DynamicColorScheme {
  const DynamicColorScheme({
    required this.brightness,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  static DynamicColorScheme fromHex(int value) {
    final Color backgroundColor = Color(value);
    final Brightness brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    final Color foregroundColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return DynamicColorScheme(
      brightness: brightness,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );
  }

  final Brightness brightness;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicColorScheme &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          foregroundColor == other.foregroundColor &&
          backgroundColor == other.backgroundColor;

  @override
  int get hashCode => brightness.hashCode ^ foregroundColor.hashCode ^ backgroundColor.hashCode;
}
