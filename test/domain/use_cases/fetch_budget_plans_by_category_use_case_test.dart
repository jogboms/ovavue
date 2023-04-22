import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetPlansByCategoryUseCase', () {
    final FetchBudgetPlansByCategoryUseCase useCase = FetchBudgetPlansByCategoryUseCase(
      plans: mockRepositories.budgetPlans,
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget plans for category', () {
      final BudgetCategoryEntity category = BudgetCategoriesMockImpl.generateCategory();
      final NormalizedBudgetPlanEntityList expectedPlans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: category)
      ];

      when(() => mockRepositories.budgetPlans.fetchByCategory(userId: '1', categoryId: '1'))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(expectedPlans.asBudgetPlanEntityList));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(<BudgetCategoryEntity>[category]));

      expectLater(useCase(userId: '1', categoryId: '1'), emits(expectedPlans));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetPlans.fetchByCategory(userId: '1', categoryId: '1'))
          .thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', categoryId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetPlans.fetchByCategory(userId: '1', categoryId: '1')).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => mockRepositories.budgetCategories.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', categoryId: '1'), emitsError(expectedError));
    });
  });
}
