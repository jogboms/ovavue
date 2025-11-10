import 'package:flutter/material.dart';

import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      context.l10n.emptyContentMessage,
      style: context.theme.textTheme.labelLarge,
    ),
  );
}
