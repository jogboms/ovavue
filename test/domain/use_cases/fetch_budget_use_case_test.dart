import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final BudgetCategoriesRepository budgetCategoriesRepository = mockRepositories.budgetCategories;
    final FetchBudgetUseCase useCase = FetchBudgetUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
      categories: budgetCategoriesRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
      reset(budgetCategoriesRepository);
    });

    test('should fetch budget', () {
      final BudgetCategoryEntityList categories = <BudgetCategoryEntity>[BudgetCategoriesMockImpl.generateCategory()];
      final NormalizedBudgetPlanEntityList plans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: categories.first),
      ];
      final NormalizedBudgetEntity expectedBudget = BudgetsMockImpl.generateNormalizedBudget(plans: plans);

      when(() => budgetsRepository.fetchOne(userId: '1', budgetId: '1'))
          .thenAnswer((_) => Stream<BudgetEntity>.value(expectedBudget.asBudgetEntity));
      when(() => budgetPlansRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetPlanEntityList>.value(plans.asBudgetPlanEntityList));
      when(() => budgetCategoriesRepository.fetch(any()))
          .thenAnswer((_) => Stream<BudgetCategoryEntityList>.value(categories));

      expectLater(useCase(userId: '1', budgetId: '1'), emits(expectedBudget));
    });

    test('should bubble fetch errors', () {
      when(() => budgetsRepository.fetchOne(userId: '1', budgetId: '1')).thenThrow(Exception('an error'));

      expect(() => useCase(userId: '1', budgetId: '1'), throwsException);
    });

    test('should bubble stream errors', () {
      final Exception expectedError = Exception('an error');

      when(() => budgetsRepository.fetchOne(userId: '1', budgetId: '1')).thenAnswer(
        (_) => Stream<BudgetEntity>.error(expectedError),
      );
      when(() => budgetPlansRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetPlanEntityList>.error(expectedError),
      );
      when(() => budgetCategoriesRepository.fetch(any())).thenAnswer(
        (_) => Stream<BudgetCategoryEntityList>.error(expectedError),
      );

      expect(useCase(userId: '1', budgetId: '1'), emitsError(expectedError));
    });
  });
}
