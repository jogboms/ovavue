import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchUserUseCase', () {
    final UsersRepository usersRepository = mockRepositories.users;
    final FetchUserUseCase useCase = FetchUserUseCase(users: usersRepository);

    final UserEntity dummyUser = UsersMockImpl.user;

    tearDown(() => reset(usersRepository));

    test('should fetch users', () {
      when(() => usersRepository.fetch(any())).thenAnswer((_) async => dummyUser);

      expect(useCase('1'), completion(dummyUser));
    });

    test('should fail gracefully with null', () {
      when(() => usersRepository.fetch(any())).thenThrow(Exception('an error'));

      expect(useCase('1'), completion(isNull));
    });
  });
}
