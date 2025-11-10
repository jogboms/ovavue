import 'package:flutter/material.dart';
import 'package:ovavue/presentation/constants.dart';

class DialogPage extends StatelessWidget {
  const DialogPage(this.builder, {super.key});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(backgroundColor: colorScheme.inverseSurface),
          color: colorScheme.onInverseSurface,
          icon: const Icon(AppIcons.close),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Material(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              width: double.infinity,
              child: builder(context),
            ),
          ),
        ),
      ],
    );
  }
}

Future<T?> showDialogPage<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => DialogPage(builder),
);
