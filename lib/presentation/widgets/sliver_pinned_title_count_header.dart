import 'package:flutter/material.dart';
import 'package:ovavue/presentation/theme.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPinnedTitleCountHeader extends StatelessWidget {
  const SliverPinnedTitleCountHeader.count({super.key, required this.title, required int count}) : value = count;

  const SliverPinnedTitleCountHeader.amount({super.key, required this.title, required Money amount}) : value = amount;

  final String title;
  final Object value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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
