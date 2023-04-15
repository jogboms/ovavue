import 'dart:math' as math show max;

import 'package:flutter/widgets.dart';

class SliverSeparatorBuilderDelegate extends SliverChildBuilderDelegate {
  factory SliverSeparatorBuilderDelegate({
    required IndexedWidgetBuilder builder,
    required IndexedWidgetBuilder separatorBuilder,
    int? childCount,
  }) =>
      SliverSeparatorBuilderDelegate._(
        builder: (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          return (index == 0 || index.isEven) ? builder(context, itemIndex) : separatorBuilder(context, itemIndex);
        },
        childCount: childCount != null ? math.max(0, childCount * 2 - 1) : null,
      );

  factory SliverSeparatorBuilderDelegate.withHeader({
    required IndexedWidgetBuilder builder,
    required IndexedWidgetBuilder separatorBuilder,
    required WidgetBuilder headerBuilder,
    int? childCount,
    bool skipTopSeparator = true,
  }) =>
      SliverSeparatorBuilderDelegate._(
        builder: (BuildContext context, int indexValue) {
          if (indexValue == 0) {
            return headerBuilder(context);
          }
          final int index = indexValue - (skipTopSeparator ? 1 : 2), itemIndex = index ~/ 2;

          return (index == 0 || index.isEven) ? builder(context, itemIndex) : separatorBuilder(context, itemIndex);
        },
        childCount: childCount != null ? math.max(1, (childCount * 2) + (skipTopSeparator ? 0 : 1)) : null,
      );

  SliverSeparatorBuilderDelegate._({required IndexedWidgetBuilder builder, int? childCount})
      : super(builder, childCount: childCount);
}
