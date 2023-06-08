import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  tearDown(mockUseCases.reset);

  group('PreferencesProvider', () {
    test('should get current location', () {
      final AccountEntity dummyAccount = AuthMockImpl.generateAccount();
      final PreferencesState expectedState = PreferencesState(
        accountKey: dummyAccount.id,
        databaseLocation: 'location',
        themeMode: ThemeMode.system,
      );
      when(mockUseCases.fetchDatabaseLocationUseCase.call).thenAnswer((_) async => expectedState.databaseLocation);

      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          accountProvider.overrideWith((_) async => dummyAccount),
        ],
      );
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.future),
        completion(expectedState),
      );
    });

    test('should import database', () {
      when(mockUseCases.importDatabaseUseCase.call).thenAnswer((_) async => true);

      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.notifier).importDatabase(),
        completion(true),
      );
    });

    test('should export database', () {
      when(mockUseCases.exportDatabaseUseCase.call).thenAnswer((_) async => true);

      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.notifier).exportDatabase(),
        completion(true),
      );
    });
  });
}
