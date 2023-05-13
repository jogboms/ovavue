import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('ExportDatabaseUseCase', () {
    final ExportDatabaseUseCase useCase = ExportDatabaseUseCase(preferences: mockRepositories.preferences);

    tearDown(mockRepositories.reset);

    test('should export database', () {
      when(mockRepositories.preferences.exportDatabase).thenAnswer((_) async => true);

      expect(useCase(), completion(true));
    });

    test('should bubble export database errors', () {
      when(mockRepositories.preferences.exportDatabase).thenThrow(Exception('an error'));

      expect(useCase.call, throwsException);
    });
  });
}
