import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

Future<void> main() async {
  tearDown(mockUseCases.reset);

  group('PreferencesProvider', () {
    test('should get current state', () {
      final dummyAccount = AuthMockImpl.generateAccount();
      final expectedState = PreferencesState(
        accountKey: dummyAccount.id,
        themeMode: ThemeMode.system,
      );
      when(mockUseCases.fetchThemeModeUseCase.call).thenAnswer((_) async => 0);

      final container = createProviderContainer(
        overrides: [
          accountProvider.overrideWith((_) async => dummyAccount),
        ],
      );
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.future),
        completion(expectedState),
      );
    });

    test('should update theme mode', () {
      when(() => mockUseCases.updateThemeModeUseCase.call(1)).thenAnswer((_) async => true);

      final container = createProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.notifier).updateThemeMode(ThemeMode.light),
        completion(true),
      );
    });
  });
}
