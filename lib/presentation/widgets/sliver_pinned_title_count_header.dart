import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../theme.dart';
import '../utils.dart';

class SliverPinnedTitleCountHeader extends StatelessWidget {
  const SliverPinnedTitleCountHeader.count({super.key, required this.title, required int count}) : value = count;

  const SliverPinnedTitleCountHeader.amount({super.key, required this.title, required Money amount}) : value = amount;

  final String title;
  final Object value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return SliverPinnedHeader(
      child: Container(
        color: colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: DefaultTextStyle(
          style: textTheme.titleSmall!.copyWith(
            color: colorScheme.onSurface,
            fontWeight: AppFontWeight.semibold,
          ),
          child: Row(
            children: <Widget>[
              Expanded(child: Text(title)),
              Text('($value)'),
            ],
          ),
        ),
      ),
    );
  }
}
