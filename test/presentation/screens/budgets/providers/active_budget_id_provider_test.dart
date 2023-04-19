import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;

  tearDown(mockUseCases.reset);

  group('ActiveBudgetIdProvider', () {
    Future<String> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );

      addTearDown(container.dispose);
      return container.read(activeBudgetIdProvider.future);
    }

    test('should show active budget id', () async {
      final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget();
      when(() => mockUseCases.fetchActiveBudgetUseCase.call(any()))
          .thenAnswer((_) => Stream<NormalizedBudgetEntity>.value(expectedBudget));

      expect(
        createProviderStream(),
        completion(expectedBudget.id),
      );
    });
  });
}
