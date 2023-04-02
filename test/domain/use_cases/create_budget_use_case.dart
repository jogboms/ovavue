import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('CreateBudgetUseCase', () {
    const CreateBudgetUseCase useCase = CreateBudgetUseCase(analytics: NoopAnalytics());
    final CreateBudgetData dummyData = CreateBudgetData(
      title: 'title',
      amount: 1,
      description: 'description',
      items: <ReferenceEntity>[],
      startedAt: DateTime(0),
      endedAt: null,
    );

    test('should create a budget', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
    });
  });
}
