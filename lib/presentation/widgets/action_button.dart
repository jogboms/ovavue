import 'package:flutter/material.dart';

import '../theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  });

  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.theme.colorScheme;

    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor ?? colorScheme.tertiaryContainer,
      ),
      onPressed: onPressed,
      child: Icon(icon, color: foregroundColor ?? colorScheme.onTertiaryContainer),
    );
  }
}
