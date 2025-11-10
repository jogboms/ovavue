import 'package:ovavue/domain/entities/budget_metadata_value_entity.dart';
import 'package:ovavue/domain/repositories/budget_metadata.dart';

class FetchBudgetMetadataUseCase {
  const FetchBudgetMetadataUseCase({
    required BudgetMetadataRepository metadata,
  }) : _metadata = metadata;

  final BudgetMetadataRepository _metadata;

  Stream<BudgetMetadataValueEntityList> call(String userId) => _metadata.fetchAll(userId);
}
