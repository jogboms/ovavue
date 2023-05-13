import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  tearDown(mockUseCases.reset);

  group('PreferencesProvider', () {
    test('should get current location', () {
      const PreferencesState expectedState = PreferencesState(databaseLocation: 'location');
      when(mockUseCases.fetchDatabaseLocationUseCase.call).thenAnswer((_) async => expectedState.databaseLocation);

      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(preferencesProvider.future),
        completion(expectedState),
      );
    });
  });
}
