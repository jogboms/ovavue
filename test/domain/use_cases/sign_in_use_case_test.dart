import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('SignInUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final SignInUseCase useCase = SignInUseCase(auth: mockRepositories.auth, analytics: analytics);

    tearDown(() {
      mockRepositories.reset();
      analytics.reset();
    });

    test('should sign in when auth state changes to valid value', () async {
      final AccountEntity dummyAccount = AuthMockImpl.generateAccount();

      when(mockRepositories.auth.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String>.value('1'));
      when(mockRepositories.auth.fetch).thenAnswer((_) async => dummyAccount);

      await expectLater(useCase(), completion(dummyAccount));
      expect(analytics.userId, dummyAccount.id);
      expect(analytics.events, containsOnce(AnalyticsEvent.login(dummyAccount.email, dummyAccount.id)));
    });

    test('should not complete until auth state changes to valid value', () {
      when(mockRepositories.auth.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), doesNotComplete);
    });

    test('should bubble errors', () {
      when(mockRepositories.auth.signIn).thenThrow(Exception('an error'));
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), throwsException);
    });

    test('should bubble auth change errors', () {
      when(mockRepositories.auth.signIn).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.error(Exception()));

      expect(useCase(), throwsException);
    });
  });
}
