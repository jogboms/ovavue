import '../entities/budget_metadata_value_entity.dart';
import '../repositories/budget_metadata.dart';

class FetchBudgetMetadataUseCase {
  const FetchBudgetMetadataUseCase({
    required BudgetMetadataRepository metadata,
  }) : _metadata = metadata;

  final BudgetMetadataRepository _metadata;

  Stream<BudgetMetadataValueEntityList> call(String userId) => _metadata.fetchAll(userId);
}
