import 'package:flutter/material.dart';

class AmountRatioDecoratedBox extends StatelessWidget {
  const AmountRatioDecoratedBox({
    super.key,
    required this.color,
    required this.ratio,
    required this.child,
    this.borderRadius,
    this.padding,
    this.onPressed,
  });

  final Color color;
  final double ratio;
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color.withValues(alpha: .015),
            border: Border.all(color: color.withValues(alpha: .025)),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                colors: [color, color, Colors.transparent],
                stops: [0, ratio, ratio],
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: colorScheme.surface.withValues(alpha: .64),
              ),
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
