import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('UpdateUserUseCase', () {
    final UpdateUserUseCase useCase = UpdateUserUseCase(users: mockRepositories.users);

    final UpdateUserData dummyUpdateUserData = UpdateUserData(
      id: 'id',
      lastSeenAt: clock.now(),
    );

    setUpAll(() {
      registerFallbackValue(dummyUpdateUserData);
    });

    tearDown(mockRepositories.reset);

    test('should update a user', () {
      when(() => mockRepositories.users.update(any())).thenAnswer((_) async => true);

      expect(useCase(dummyUpdateUserData), completion(true));
    });

    test('should bubble update errors', () {
      when(() => mockRepositories.users.update(any())).thenThrow(Exception('an error'));

      expect(() => useCase(dummyUpdateUserData), throwsException);
    });
  });
}
