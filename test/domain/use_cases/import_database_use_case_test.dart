import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('ImportDatabaseUseCase', () {
    final ImportDatabaseUseCase useCase = ImportDatabaseUseCase(preferences: mockRepositories.preferences);

    tearDown(mockRepositories.reset);

    test('should import database', () {
      when(mockRepositories.preferences.importDatabase).thenAnswer((_) async => true);

      expect(useCase(), completion(true));
    });

    test('should bubble import database errors', () {
      when(mockRepositories.preferences.importDatabase).thenThrow(Exception('an error'));

      expect(useCase.call, throwsException);
    });
  });
}
