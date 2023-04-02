import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('CreateBudgetUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final CreateBudgetUseCase useCase = CreateBudgetUseCase(analytics: analytics);
    final CreateBudgetData dummyData = CreateBudgetData(
      title: 'title',
      amount: 1,
      description: 'description',
      items: <ReferenceEntity>[],
      startedAt: DateTime(0),
      endedAt: null,
    );

    tearDown(analytics.reset);

    test('should create a budget', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble create errors', () {
      expect(() => useCase(userId: '1', budget: dummyData), throwsUnimplementedError);
    });
  });
}
