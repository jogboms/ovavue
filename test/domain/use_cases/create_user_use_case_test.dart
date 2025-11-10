import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateUserUseCase', () {
    final analytics = LogAnalytics();
    final useCase = CreateUserUseCase(
      users: mockRepositories.users,
      analytics: analytics,
    );

    final dummyAccountModel = AuthMockImpl.generateAccount();
    final dummyModel = dummyAccountModel.toUserEntity();

    setUpAll(() {
      registerFallbackValue(dummyAccountModel);
      registerFallbackValue(dummyModel);
    });

    tearDown(() {
      mockRepositories.reset();
      analytics.reset();
    });

    test('should create a user', () async {
      when(() => mockRepositories.users.create(any())).thenAnswer((_) async => dummyModel);

      await expectLater(useCase(dummyAccountModel), completion(dummyModel));
      expect(analytics.events, containsOnce(AnalyticsEvent.createUser(dummyModel.id)));
    });

    test('should bubble create errors', () {
      when(() => mockRepositories.users.create(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyAccountModel), throwsException);
    });
  });
}

extension on AccountEntity {
  UserEntity toUserEntity() => UserEntity(id: id, path: 'path', createdAt: DateTime(0));
}
