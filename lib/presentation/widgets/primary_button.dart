import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.caption, required this.onPressed, this.enabled = true});

  final String caption;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) => FilledButton.tonal(
    onPressed: enabled ? onPressed : null,
    child: Text(caption),
  );
}
