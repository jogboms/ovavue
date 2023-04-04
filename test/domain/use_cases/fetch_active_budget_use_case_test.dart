import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchActiveBudgetUseCase', () {
    final BudgetsRepository budgetsRepository = mockRepositories.budgets;
    final BudgetPlansRepository budgetPlansRepository = mockRepositories.budgetPlans;
    final FetchActiveBudgetUseCase useCase = FetchActiveBudgetUseCase(
      budgets: budgetsRepository,
      plans: budgetPlansRepository,
    );

    tearDown(() {
      reset(budgetsRepository);
      reset(budgetPlansRepository);
    });

    test('should fetch active budget', () {
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
