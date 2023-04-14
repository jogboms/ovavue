import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/presentation.dart';

Widget _buildScrollViewApp(SliverChildDelegate delegate) {
  return MaterialApp(home: CustomScrollView(slivers: <Widget>[SliverList(delegate: delegate)]));
}

void main() {
  group('SliverSeparatorBuilderDelegate', () {
    testWidgets('works normally', (WidgetTester tester) async {
      final SliverSeparatorBuilderDelegate delegate = SliverSeparatorBuilderDelegate(
        builder: (BuildContext a, int b) => const Text('data'),
        separatorBuilder: (BuildContext a, int b) => const Text('separator'),
        childCount: 2,
      );

      expect(delegate.childCount, 3);

      await tester.pumpWidget(_buildScrollViewApp(delegate));

      expect(find.text('data'), findsNWidgets(2));
      expect(find.text('separator'), findsOneWidget);
    });

    testWidgets('works with headers', (WidgetTester tester) async {
      final SliverSeparatorBuilderDelegate delegate = SliverSeparatorBuilderDelegate.withHeader(
        builder: (BuildContext a, int b) => const Text('data'),
        separatorBuilder: (BuildContext a, int b) => const Text('separator'),
        headerBuilder: (BuildContext a) => const Text('header'),
        childCount: 2,
      );

      expect(delegate.childCount, 4);

      await tester.pumpWidget(_buildScrollViewApp(delegate));

      expect(find.text('data'), findsNWidgets(2));
      expect(find.text('separator'), findsOneWidget);
      expect(find.text('header'), findsOneWidget);
    });

    testWidgets('can include top separator with header', (WidgetTester tester) async {
      final SliverSeparatorBuilderDelegate delegate = SliverSeparatorBuilderDelegate.withHeader(
        builder: (BuildContext a, int b) => const Text('data'),
        separatorBuilder: (BuildContext a, int b) => const Text('separator'),
        headerBuilder: (BuildContext a) => const Text('header'),
        childCount: 2,
        skipTopSeparator: false,
      );

      expect(delegate.childCount, 5);

      await tester.pumpWidget(_buildScrollViewApp(delegate));

      expect(find.text('data'), findsNWidgets(2));
      expect(find.text('separator'), findsNWidgets(2));
      expect(find.text('header'), findsOneWidget);
    });
  });
}
