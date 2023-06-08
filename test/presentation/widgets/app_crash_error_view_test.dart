import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

void main() {
  group('AppCrashErrorView', () {
    final AccountEntity dummyAccount = AuthMockImpl.generateAccount();

    tearDown(mockUseCases.reset);

    testWidgets('smoke test', (WidgetTester tester) async {
      when(mockUseCases.fetchAccountUseCase).thenAnswer((_) async => dummyAccount);
      when(mockUseCases.fetchThemeModeUseCase).thenAnswer((_) async => 1);
      when(mockUseCases.fetchDatabaseLocationUseCase).thenAnswer((_) async => 'db.sqlite');

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
