import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetPlanUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetPlanUseCase useCase = DeleteBudgetPlanUseCase(analytics: analytics);

    tearDown(analytics.reset);

    test('should delete a budget plan', () {
      expect(() => useCase('path'), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble delete errors', () {
      expect(() => useCase('path'), throwsUnimplementedError);
    });
  });
}
