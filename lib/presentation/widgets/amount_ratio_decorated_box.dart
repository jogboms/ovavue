import 'package:flutter/material.dart';

class AmountRatioDecoratedBox extends StatelessWidget {
  const AmountRatioDecoratedBox({
    super.key,
    required this.color,
    required this.ratio,
    required this.child,
    this.onPressed,
  });

  final Color color;
  final double ratio;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withOpacity(.015),
          border: Border.all(color: color.withOpacity(.025)),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color, color, Colors.transparent],
              stops: <double>[0, ratio, ratio],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: child,
        ),
      ),
    );
  }
}
