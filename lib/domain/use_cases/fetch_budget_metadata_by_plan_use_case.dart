import '../entities/budget_metadata_value_entity.dart';
import '../repositories/budget_metadata.dart';

class FetchBudgetMetadataByPlanUseCase {
  const FetchBudgetMetadataByPlanUseCase({
    required BudgetMetadataRepository metadata,
  }) : _metadata = metadata;

  final BudgetMetadataRepository _metadata;

  Stream<BudgetMetadataValueEntityList> call({
    required String userId,
    required String planId,
  }) =>
      _metadata.fetchAllByPlan(userId: userId, planId: planId);
}
