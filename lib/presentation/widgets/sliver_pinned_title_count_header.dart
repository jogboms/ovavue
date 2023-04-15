import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPinnedTitleCountHeader extends StatelessWidget {
  const SliverPinnedTitleCountHeader({super.key, required this.title, required this.count});

  final String title;
  final int count;

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
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.outline,
          ),
          child: Row(
            children: <Widget>[
              Expanded(child: Text(title)),
              Text('($count)'),
            ],
          ),
        ),
      ),
    );
  }
}
