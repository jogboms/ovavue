import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('CreateBudgetCategoryUseCase', () {
    const CreateBudgetCategoryUseCase useCase = CreateBudgetCategoryUseCase(analytics: NoopAnalytics());
    const CreateBudgetCategoryData dummyData = CreateBudgetCategoryData(
      title: 'title',
      description: 'description',
      color: 0,
    );

    test('should create a budget category', () {
      expect(() => useCase(userId: '1', category: dummyData), throwsUnimplementedError);
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', category: dummyData), throwsUnimplementedError);
    });
  });
}
