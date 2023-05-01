import 'package:flutter/material.dart';

import 'action_button.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({
    super.key,
    this.alignment = Alignment.centerLeft,
    this.backgroundColor,
    required this.actions,
  });

  final Alignment alignment;
  final Color? backgroundColor;
  final List<ActionButton> actions;

  static const double _padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2),
      color: backgroundColor,
      alignment: alignment,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: _padding,
        children: actions,
      ),
    );
  }
}
