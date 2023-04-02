import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('CreateBudgetAllocationUseCase', () {
    const CreateBudgetAllocationUseCase useCase = CreateBudgetAllocationUseCase(analytics: NoopAnalytics());
    final CreateBudgetAllocationData dummyData = CreateBudgetAllocationData(
      amount: 1,
      budget: const ReferenceEntity(id: '1', path: 'path'),
      item: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    test('should create a budget allocation', () {
      expect(() => useCase(userId: '1', allocation: dummyData), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', allocation: dummyData), throwsUnimplementedError);
    });
  });
}
