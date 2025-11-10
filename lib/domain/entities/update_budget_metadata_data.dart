import 'package:ovavue/domain/entities/budget_metadata_value_operation.dart';

class UpdateBudgetMetadataData {
  const UpdateBudgetMetadataData({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.operations,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final Set<BudgetMetadataValueOperation> operations;
}
