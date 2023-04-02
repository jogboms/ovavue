import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('SignOutUseCase', () {
    final AuthRepository authRepository = mockRepositories.auth;
    final SignOutUseCase useCase = SignOutUseCase(auth: authRepository, analytics: const NoopAnalytics());

    tearDown(() => reset(authRepository));

    test('should sign out when auth state changes to null', () {
      when(authRepository.signOut).thenAnswer((_) async {});
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), completes);
    });

    test('should not complete until auth state change to null', () {
      when(authRepository.signOut).thenAnswer((_) async {});
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value('1'));

      expect(useCase(), doesNotComplete);
    });

    test('should bubble errors', () {
      when(authRepository.signOut).thenThrow(Exception('an error'));
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), throwsException);
    });

    test('should bubble auth change errors', () {
      when(authRepository.signOut).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.error(Exception()));

      expect(useCase(), throwsException);
    });
  });
}
