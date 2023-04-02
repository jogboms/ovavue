import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetItemUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetItemUseCase useCase = CreateBudgetItemUseCase(analytics: analytics);
    final CreateBudgetItemData dummyData = CreateBudgetItemData(
      title: 'title',
      description: 'description',
      category: const ReferenceEntity(id: '1', path: 'path'),
      startedAt: DateTime(0),
      endedAt: null,
    );

    tearDown(analytics.reset);

    test('should create a budget item', () {
      expect(() => useCase(userId: '1', item: dummyData), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', item: dummyData), throwsUnimplementedError);
    });
  });
}
