import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetCategoriesUseCase', () {
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final FetchBudgetCategoriesUseCase useCase = FetchBudgetCategoriesUseCase(
      categories: budgetCategoriesRepository,
    );

    tearDown(() => reset(budgetCategoriesRepository));

    test('should fetch budget categories', () {
      expect(() => useCase('1'), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase('1'), throwsUnimplementedError);
    });

    test('should bubble stream errors', () {
      expect(() => useCase('1'), throwsUnimplementedError);
    });
  });
}
