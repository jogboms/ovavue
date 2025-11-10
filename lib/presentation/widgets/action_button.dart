import 'package:flutter/material.dart';

import 'package:ovavue/presentation/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  }) : borderColor = null;

  const ActionButton.outline({
    super.key,
    required this.icon,
    required this.borderColor,
    required this.onPressed,
  }) : backgroundColor = Colors.transparent,
       foregroundColor = borderColor;

  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final borderColor = this.borderColor;

    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          side: borderColor != null ? BorderSide(color: borderColor, width: 2) : BorderSide.none,
          borderRadius: AppBorderRadius.c12,
        ),
        backgroundColor: backgroundColor ?? colorScheme.tertiaryContainer,
      ),
      onPressed: onPressed,
      child: Icon(icon, color: foregroundColor ?? colorScheme.onTertiaryContainer),
    );
  }
}
