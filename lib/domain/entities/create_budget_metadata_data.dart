import 'budget_metadata_value_operation.dart';

class CreateBudgetMetadataData {
  const CreateBudgetMetadataData({
    required this.title,
    required this.description,
    required this.operations,
  });

  final String title;
  final String description;
  final Set<BudgetMetadataValueOperation> operations;
}
