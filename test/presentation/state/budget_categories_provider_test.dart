import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';

import '../../utils.dart';

Future<void> main() async {
  group('BudgetCategoriesProvider', () {
    final dummyUser = UsersMockImpl.user;

    tearDown(mockUseCases.reset);

    Future<List<BudgetCategoryViewModel>> createProviderStream() {
      final container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
        ],
      );
      return container.readAsync(budgetCategoriesProvider.future);
    }

    test('should initialize with empty state', () {
      when(
        () => mockUseCases.fetchBudgetCategoriesUseCase.call(any()),
      ).thenAnswer((_) => Stream<List<BudgetCategoryEntity>>.value([]));

      expect(createProviderStream(), completes);
    });

    test('should emit fetched tags', () {
      final expectedBudgetCategories = List<BudgetCategoryEntity>.filled(
        3,
        BudgetCategoriesMockImpl.generateCategory(),
      );
      when(
        () => mockUseCases.fetchBudgetCategoriesUseCase.call(any()),
      ).thenAnswer((_) => Stream<List<BudgetCategoryEntity>>.value(expectedBudgetCategories));

      expect(
        createProviderStream(),
        completion(expectedBudgetCategories.map(BudgetCategoryViewModel.fromEntity).toList()),
      );
    });
  });
}
