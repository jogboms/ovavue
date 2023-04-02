import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils.dart';

Future<void> main() async {
  group('AccountProvider', () {
    final AccountEntity dummyAccount = AuthMockImpl.generateAccount();

    tearDown(mockUseCases.reset);

    test('should get current account', () {
      when(mockUseCases.fetchAccountUseCase.call).thenAnswer((_) async => dummyAccount);

      final ProviderContainer container = createProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(accountProvider.future),
        completion(dummyAccount),
      );
    });
  });
}
