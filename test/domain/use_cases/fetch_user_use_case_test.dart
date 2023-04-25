import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchUserUseCase', () {
    final FetchUserUseCase useCase = FetchUserUseCase(users: mockRepositories.users);

    final UserEntity dummyUser = UsersMockImpl.user;

    tearDown(mockRepositories.reset);

    test('should fetch users', () {
      when(() => mockRepositories.users.fetch(any())).thenAnswer((_) async => dummyUser);

      expect(useCase('1'), completion(dummyUser));
    });

    test('should fail gracefully with null', () {
      when(() => mockRepositories.users.fetch(any())).thenThrow(Exception('an error'));

      expect(useCase('1'), completion(isNull));
    });
  });
}
