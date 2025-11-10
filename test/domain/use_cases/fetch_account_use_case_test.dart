import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchAccountUseCase', () {
    final useCase = FetchAccountUseCase(auth: mockRepositories.auth);

    final dummyAccount = AuthMockImpl.generateAccount();

    tearDown(mockRepositories.reset);

    test('should fetch auth', () {
      when(mockRepositories.auth.fetch).thenAnswer((_) async => dummyAccount);

      expect(useCase(), completion(dummyAccount));
    });

    test('should bubble fetch errors', () {
      when(mockRepositories.auth.fetch).thenThrow(Exception('an error'));

      // ignore: unnecessary_lambdas, causes the test to fail
      expect(() => useCase(), throwsException);
    });
  });
}
