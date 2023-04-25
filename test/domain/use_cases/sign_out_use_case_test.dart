import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('SignOutUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final SignOutUseCase useCase = SignOutUseCase(auth: mockRepositories.auth, analytics: analytics);

    tearDown(() {
      mockRepositories.reset();
      analytics.reset();
    });

    test('should sign out when auth state changes to null', () async {
      await analytics.setUserId('1');

      when(mockRepositories.auth.signOut).thenAnswer((_) async {});
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      await expectLater(useCase(), completes);
      expect(analytics.userId, null);
      expect(analytics.events, containsOnce(AnalyticsEvent.logout));
    });

    test('should not complete until auth state change to null', () {
      when(mockRepositories.auth.signOut).thenAnswer((_) async {});
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value('1'));

      expect(useCase(), doesNotComplete);
    });

    test('should bubble errors', () {
      when(mockRepositories.auth.signOut).thenThrow(Exception('an error'));
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.value(null));

      expect(useCase(), throwsException);
    });

    test('should bubble auth change errors', () {
      when(mockRepositories.auth.signOut).thenAnswer((_) async => '1');
      when(() => mockRepositories.auth.onAuthStateChanged).thenAnswer((_) => Stream<String?>.error(Exception()));

      expect(useCase(), throwsException);
    });
  });
}
