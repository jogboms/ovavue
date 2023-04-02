import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('FetchBudgetAllocationsUseCase', () {
    const FetchBudgetAllocationsUseCase useCase = FetchBudgetAllocationsUseCase();

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
