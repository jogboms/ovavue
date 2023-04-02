import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('SignInUseCase', () {
    final AuthRepository authRepository = mockRepositories.auth;
    final SignInUseCase useCase = SignInUseCase(auth: authRepository, analytics: const NoopAnalytics());

    tearDown(() => reset(authRepository));

    test('should sign in when auth state changes to valid value', () {
      final AccountEntity dummyAccount = AuthMockImpl.generateAccount();

      when(authRepository.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String>.value('1'));
      when(mockRepositories.auth.fetch).thenAnswer((_) async => dummyAccount);

      expect(useCase(), completion(dummyAccount));
    });

    test('should not complete until auth state changes to valid value', () {
      when(authRepository.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), doesNotComplete);
    });

    test('should bubble errors', () {
      when(authRepository.signIn).thenThrow(Exception('an error'));
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), throwsException);
    });

    test('should bubble auth change errors', () {
      when(authRepository.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.error(Exception()));

      expect(useCase(), throwsException);
    });
  });
}
