import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetAllocationsUseCase', () {
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchBudgetAllocationsUseCase useCase = FetchBudgetAllocationsUseCase(
      allocations: budgetAllocationsRepository,
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetAllocationsRepository);
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch budget allocations', () {
      expect(() => useCase(userId: '1', budgetId: '1'), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', budgetId: '1'), throwsUnimplementedError);
    });

    test('should bubble stream errors', () {
      expect(() => useCase(userId: '1', budgetId: '1'), throwsUnimplementedError);
    });
  });
}
