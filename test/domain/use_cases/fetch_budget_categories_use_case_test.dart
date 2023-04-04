import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('FetchBudgetCategoriesUseCase', () {
    const FetchBudgetCategoriesUseCase useCase = FetchBudgetCategoriesUseCase();

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
