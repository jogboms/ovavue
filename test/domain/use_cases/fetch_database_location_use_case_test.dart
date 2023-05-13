import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchDatabaseLocationUseCase', () {
    final FetchDatabaseLocationUseCase useCase =
        FetchDatabaseLocationUseCase(preferences: mockRepositories.preferences);

    tearDown(mockRepositories.reset);

    test('should fetch database location', () {
      when(mockRepositories.preferences.fetchDatabaseLocation).thenAnswer((_) async => 'location');

      expect(useCase(), completion('location'));
    });

    test('should bubble fetch database errors', () {
      when(mockRepositories.preferences.fetchDatabaseLocation).thenThrow(Exception('an error'));

      expect(useCase.call, throwsException);
    });
  });
}
