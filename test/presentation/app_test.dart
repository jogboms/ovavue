import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';

import '../utils.dart';

void main() {
  group('App', () {
    final dummyAccount = AuthMockImpl.generateAccount();

    tearDown(mockUseCases.reset);

    testWidgets('smoke test', (WidgetTester tester) async {
      when(mockUseCases.fetchAccountUseCase.call).thenAnswer((_) async => dummyAccount);
      when(mockUseCases.fetchThemeModeUseCase.call).thenAnswer((_) async => 1);

      await tester.pumpWidget(
        createApp(
          registry: createRegistry().withMockedUseCases(),
          includeMaterial: false,
        ),
      );

      await tester.pump();

      expect(find.byKey(const ObjectKey(Environment.testing)), findsOneWidget);
      expect(find.byType(ActiveBudgetPage), findsOneWidget);
    });
  });
}
