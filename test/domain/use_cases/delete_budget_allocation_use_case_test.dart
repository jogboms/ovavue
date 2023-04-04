import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('DeleteBudgetAllocationUseCase', () {
    final LogAnalytics analytics = LogAnalytics();
    final DeleteBudgetAllocationUseCase useCase = DeleteBudgetAllocationUseCase(analytics: analytics);

    tearDown(analytics.reset);

    test('should delete a budget allocation', () {
      expect(() => useCase('path'), throwsUnimplementedError);
      // TODO(Jogboms): test analytics event
    });

    test('should bubble delete errors', () {
      expect(() => useCase('path'), throwsUnimplementedError);
    });
  });
}
