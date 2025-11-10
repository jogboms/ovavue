import 'package:ovavue/domain/entities/reference_entity.dart';

sealed class BudgetMetadataValueOperation {}

class BudgetMetadataValueCreationOperation implements BudgetMetadataValueOperation {
  const BudgetMetadataValueCreationOperation({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
}

class BudgetMetadataValueModificationOperation implements BudgetMetadataValueOperation {
  const BudgetMetadataValueModificationOperation({
    required this.reference,
    required this.title,
    required this.value,
  });

  final ReferenceEntity reference;
  final String title;
  final String value;
}

class BudgetMetadataValueRemovalOperation implements BudgetMetadataValueOperation {
  const BudgetMetadataValueRemovalOperation({
    required this.reference,
  });

  final ReferenceEntity reference;
}
