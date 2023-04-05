import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetsUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final FetchBudgetsUseCase useCase = FetchBudgetsUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
      categories: budgetCategoriesRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
      reset(budgetCategoriesRepository);
    });

    test('should fetch budgets', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntityList plans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first),
      ];
      final NormalizedBudgetEntityList expectedBudgets = <NormalizedBudgetEntity>[
        BudgetsMockImpl.generateNormalizedBudget(plans: plans)
      ];

      when(() => budgetsRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetEntityList>.value(expectedBudgets.asBudgetEntityList));
      when(() => budgetPlansRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(plans.asBudgetPlanEntityList));
      when(() => budgetCategoriesRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase('1'), emits(expectedBudgets));
    });

    test('should bubble fetch errors', () {
      when(() => budgetsRepository.fetch('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetsRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetEntityList>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => budgetCategoriesRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
