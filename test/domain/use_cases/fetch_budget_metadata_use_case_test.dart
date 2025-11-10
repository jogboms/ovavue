import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

import '../../utils.dart';

void main() {
  group('FetchBudgetMetadataUseCase', () {
    final useCase = FetchBudgetMetadataUseCase(
      metadata: mockRepositories.budgetMetadata,
    );

    tearDown(mockRepositories.reset);

    test('should fetch budget metadata', () {
      final key = BudgetMetadataMockImpl.generateMetadataKey();
      final expectedMetadata = <BudgetMetadataValueEntity>[
        BudgetMetadataMockImpl.generateMetadataValue(key: key),
      ];

      when(
        () => mockRepositories.budgetMetadata.fetchAll(any()),
      ).thenAnswer((_) => Stream<BudgetMetadataValueEntityList>.value(expectedMetadata));

      expectLater(useCase('1'), emits(expectedMetadata));
    });

    test('should bubble fetch errors', () {
      when(() => mockRepositories.budgetMetadata.fetchAll('1')).thenThrow(Exception('an error'));

      expect(() => useCase('1'), throwsException);
    });

    test('should bubble stream errors', () {
      final expectedError = Exception('an error');

      when(() => mockRepositories.budgetMetadata.fetchAll(any())).thenAnswer(
        (_) => Stream<BudgetMetadataValueEntityList>.error(expectedError),
      );

      expect(useCase('1'), emitsError(expectedError));
    });
  });
}
