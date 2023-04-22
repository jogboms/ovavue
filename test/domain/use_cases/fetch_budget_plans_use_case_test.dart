import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetPlansUseCase', () {
    final FetchBudgetPlansUseCase useCase = FetchBudgetPlansUseCase(
      plans: mockRepositories.budgetPlans,
      categories: mockRepositories.budgetCategories,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget plans', () {
      final BudgetCategoryEntity category = BudgetCategoriesMockImpl.generateCategory();
      final NormalizedBudgetPlanEntityList expectedPlans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: category)
      ];

      when(() => mockRepositories.budgetPlans.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(expectedPlans.asBudgetPlanEntityList));
      when(() => mockRepositories.budgetCategories.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(<BudgetCategoryEntity>[category]));

      expectLater(useCase('1'), emits(expectedPlans));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetPlans.fetch('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => mockRepositories.budgetPlans.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => mockRepositories.budgetCategories.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
