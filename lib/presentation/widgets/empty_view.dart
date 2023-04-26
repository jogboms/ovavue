import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.emptyContentMessage,
        style: context.theme.textTheme.labelLarge,
      ),
    );
  }
}
