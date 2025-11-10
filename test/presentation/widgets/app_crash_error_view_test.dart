import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

void main() {
  group('AppCrashErrorView', () {
    final dummyAccount = AuthMockImpl.generateAccount();

    tearDown(mockUseCases.reset);

    testWidgets('smoke test', (WidgetTester tester) async {
      when(mockUseCases.fetchAccountUseCase.call).thenAnswer((_) async => dummyAccount);
      when(mockUseCases.fetchThemeModeUseCase.call).thenAnswer((_) async => 1);

      await tester.pumpWidget(
        createApp(
          registry: createRegistry().withMockedUseCases(),
          home: const AppCrashErrorView(),
        ),
      );

      await tester.pump();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
