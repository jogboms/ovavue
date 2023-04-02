import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateUserUseCase', () {
    final UsersRepository usersRepository = mockRepositories.users;
    final UpdateUserUseCase useCase = UpdateUserUseCase(users: usersRepository);

    final UpdateUserData dummyUpdateUserData = UpdateUserData(
      id: 'id',
      lastSeenAt: clock.now(),
    );

    setUpAll(() {
      registerFallbackValue(dummyUpdateUserData);
    });

    tearDown(() => reset(usersRepository));

    test('should update a user', () {
      when(() => usersRepository.update(any())).thenAnswer((_) async => true);

      expect(useCase(dummyUpdateUserData), completion(true));
    });

    test('should bubble update errors', () {
      when(() => usersRepository.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyUpdateUserData), throwsException);
    });
  });
}
