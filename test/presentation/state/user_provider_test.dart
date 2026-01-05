import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

Future<void> main() async {
  group('UserProvider', () {
    final dummyAccount = AuthMockImpl.generateAccount();
    final dummyUser = UsersMockImpl.user;

    setUpAll(() {
      registerFallbackValue(dummyAccount);
      registerFallbackValue(dummyUser);
    });

    tearDown(mockUseCases.reset);

    Future<UserEntity> createProviderFuture() {
      final container = createProviderContainer(
        overrides: [
          accountProvider.overrideWith((_) async => dummyAccount),
        ],
      );
      return container.read(userProvider.future);
    }

    test('should get current user', () async {
      when(() => mockUseCases.fetchUserUseCase.call(any())).thenAnswer((_) async => dummyUser);

      expect(createProviderFuture(), completion(dummyUser));
    });

    test('should create new user on empty current user', () async {
      when(() => mockUseCases.fetchUserUseCase.call(any())).thenAnswer((_) async => null);
      when(() => mockUseCases.createUserUseCase.call(dummyAccount)).thenAnswer((_) async => dummyUser);

      expect(createProviderFuture(), completion(dummyUser));
    });
  });
}
