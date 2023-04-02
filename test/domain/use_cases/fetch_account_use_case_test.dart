import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchAccountUseCase', () {
    final AuthRepository authRepository = mockRepositories.auth;
    final FetchAccountUseCase useCase = FetchAccountUseCase(auth: authRepository);

    final AccountEntity dummyAccount = AuthMockImpl.generateAccount();

    tearDown(() => reset(authRepository));

    test('should fetch auth', () {
      when(authRepository.fetch).thenAnswer((_) async => dummyAccount);

      expect(useCase(), completion(dummyAccount));
    });

    test('should bubble fetch errors', () {
      when(authRepository.fetch).thenThrow(Exception('an error'));

      // ignore: unnecessary_lambdas, causes the test to fail
      expect(() => useCase(), throwsException);
    });
  });
}
