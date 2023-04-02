import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('CreateBudgetItemUseCase', () {
    const CreateBudgetItemUseCase useCase = CreateBudgetItemUseCase(analytics: NoopAnalytics());
    final CreateBudgetItemData dummyData = CreateBudgetItemData(
      title: 'title',
      description: 'description',
      category: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    test('should create a budget item', () {
      expect(() => useCase(userId: '1', item: dummyData), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', item: dummyData), throwsUnimplementedError);
    });
  });
}
