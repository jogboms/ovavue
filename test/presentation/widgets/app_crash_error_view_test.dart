import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

void main() {
  group('AppCrashErrorView', () {
    testWidgets('smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(createApp(home: const AppCrashErrorView()));

      await tester.pump();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
