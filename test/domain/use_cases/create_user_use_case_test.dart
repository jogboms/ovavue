import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateUserUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateUserUseCase useCase = CreateUserUseCase(
      users: mockRepositories.users,
      analytics: analytics,
    );

    final AccountEntity dummyAccountModel = AuthMockImpl.generateAccount();

    setUpAll(() {
      registerFallbackValue(dummyAccountModel);
    });

    tearDown(() {
      mockRepositories.reset();
      analytics.reset();
    });

    test('should create a user', () async {
      when(() => mockRepositories.users.create(any())).thenAnswer((_) async => dummyAccountModel.id);

      await expectLater(useCase(dummyAccountModel), completion(dummyAccountModel.id));
      expect(analytics.events, containsOnce(AnalyticsEvent.createUser(dummyAccountModel.id)));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.users.create(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyAccountModel), throwsException);
    });
  });
}
