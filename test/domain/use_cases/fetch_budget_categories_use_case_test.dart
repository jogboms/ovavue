import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetCategoriesUseCase', () {
    final FetchBudgetCategoriesUseCase useCase = FetchBudgetCategoriesUseCase(
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget categories', () {
      final BudgetCategoryEntityList expectedBudgetCategories = BudgetCategoryEntityList.generate(
        3,
        (_) => BudgetCategoriesMockImpl.generateCategory(),
      );

      when(() => mockRepositories.budgetCategories.fetchAll(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.value(expectedBudgetCategories),
      );

      expect(useCase('1'), emits(expectedBudgetCategories));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetCategories.fetchAll(any())).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetCategories.fetchAll(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
