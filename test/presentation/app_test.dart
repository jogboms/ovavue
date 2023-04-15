import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/presentation.dart';

import '../utils.dart';

void main() {
  group('App', () {
    testWidgets('smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(
        createApp(
          registry: createRegistry().withMockedUseCases(),
          includeMaterial: false,
        ),
      );

      await tester.pump();

      expect(find.byKey(const Key('TESTING')), findsOneWidget);
      expect(find.byType(ActiveBudgetPage), findsOneWidget);
    });
  });
}
