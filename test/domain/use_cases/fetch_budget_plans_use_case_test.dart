import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('FetchBudgetPlansUseCase', () {
    const FetchBudgetPlansUseCase useCase = FetchBudgetPlansUseCase();

    test('should fetch budget plans', () {
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
