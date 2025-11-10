import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverExpandableGroup<T> extends StatefulWidget {
  const SliverExpandableGroup({
    super.key,
    required this.header,
    required this.values,
    required this.itemBuilder,
    this.expanded = false,
    this.bottom,
  });

  final Widget header;
  final List<T> values;
  final Widget Function(T) itemBuilder;
  final bool expanded;
  final Widget? bottom;

  @override
  State<SliverExpandableGroup<T>> createState() => _SliverExpandableGroupState<T>();
}

class _SliverExpandableGroupState<T> extends State<SliverExpandableGroup<T>> {
  late bool _expanded = widget.expanded;

  @override
  void didUpdateWidget(covariant SliverExpandableGroup<T> oldWidget) {
    if (widget.expanded != _expanded) {
      setState(() => _expanded = widget.expanded);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Widget child = SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: MultiSliver(
        children: <Widget>[
          SliverList.separated(
            itemBuilder: (_, int index) => widget.itemBuilder(widget.values[index]),
            separatorBuilder: (_, _) => const SizedBox(height: 4),
            itemCount: widget.values.length,
          ),
          if (widget.bottom case final Widget bottom)
            SliverPadding(
              padding: const EdgeInsets.only(top: 8.0),
              sliver: SliverToBoxAdapter(child: bottom),
            ),
        ],
      ),
    );

    return SliverStickyHeader(
      header: Material(
        child: InkWell(
          child: Ink(
            color: colorScheme.surface,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: widget.header),
                AnimatedRotation(
                  turns: _expanded ? 0 : 0.5,
                  duration: kThemeChangeDuration,
                  child: const Icon(AppIcons.arrowDown),
                ),
              ],
            ),
          ),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
      ),
      sliver: SliverAnimatedSwitcher(
        duration: kThemeChangeDuration,
        child: _expanded ? child : const SliverToBoxAdapter(child: SizedBox.shrink()),
      ),
    );
  }
}
