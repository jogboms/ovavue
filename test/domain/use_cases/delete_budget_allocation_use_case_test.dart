import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final BudgetAllocationsRepository budgetAllocationsRepository = mockRepositories.budgetAllocations;
    final DeleteBudgetAllocationUseCase useCase = DeleteBudgetAllocationUseCase(
      allocations: budgetAllocationsRepository,
      analytics: analytics,
    );

    tearDown(() {
      analytics.reset();
      reset(budgetAllocationsRepository);
    });

    test('should delete a budget allocation', () {
      expect(() => useCase('path'), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble delete errors', () {
      expect(() => useCase('path'), throwsUnimplementedError);
    });
  });
}
