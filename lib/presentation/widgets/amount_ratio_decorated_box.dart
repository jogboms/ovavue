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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color.withOpacity(.015),
            border: Border.all(color: color.withOpacity(.025)),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                colors: <Color>[color, color, Colors.transparent],
                stops: <double>[0, ratio, ratio],
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: colorScheme.surface.withOpacity(.64),
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
