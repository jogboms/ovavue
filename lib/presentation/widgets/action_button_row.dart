import 'package:flutter/material.dart';

import 'action_button.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({super.key, required this.actions});

  final List<ActionButton> actions;

  static const double _padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _padding),
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: _padding,
        children: actions,
      ),
    );
  }
}
