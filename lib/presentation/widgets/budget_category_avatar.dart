import 'package:flutter/material.dart';
import 'package:ovavue/presentation.dart';

class BudgetCategoryAvatar extends StatelessWidget {
  const BudgetCategoryAvatar({
    super.key,
    required this.icon,
    required this.colorScheme,
  })  : radius = null,
        inverse = false;

  const BudgetCategoryAvatar.small({
    super.key,
    required this.icon,
    required this.colorScheme,
  })  : radius = 16,
        inverse = false;

  const BudgetCategoryAvatar.inverse({
    super.key,
    required this.icon,
    required this.colorScheme,
  })  : radius = 24,
        inverse = true;

  final IconData icon;
  final BudgetCategoryColorScheme colorScheme;
  final double? radius;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: inverse ? colorScheme.foreground : colorScheme.background,
      foregroundColor: inverse ? colorScheme.background : colorScheme.foreground,
      radius: radius,
      child: Icon(icon, size: radius),
    );
  }
}
