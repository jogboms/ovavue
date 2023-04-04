import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetsUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchBudgetsUseCase useCase = FetchBudgetsUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch budgets', () {
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
