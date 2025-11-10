import 'package:ovavue/core.dart';
import 'package:ovavue/domain/entities/budget_plan_entity.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/repositories/budget_metadata.dart';
import 'package:ovavue/domain/repositories/budget_plans.dart';
import 'package:rxdart/rxdart.dart';

class FetchBudgetPlansByMetadataUseCase {
  const FetchBudgetPlansByMetadataUseCase({
    required BudgetPlansRepository plans,
    required BudgetMetadataRepository metadata,
  }) : _plans = plans,
       _metadata = metadata;

  final BudgetPlansRepository _plans;
  final BudgetMetadataRepository _metadata;

  Stream<BudgetPlanEntityList> call({
    required String userId,
    required String metadataId,
  }) => CombineLatestStream.combine2(
    _plans.fetchAll(userId),
    _metadata.fetchPlansByMetadata(userId: userId, metadataId: metadataId),
    (BudgetPlanEntityList plans, List<ReferenceEntity> references) {
      final plansById = plans.foldToMap((BudgetPlanEntity e) => e.id);
      return references
          .map((ReferenceEntity e) => plansById[e.id])
          .whereType<BudgetPlanEntity>()
          .toList(growable: false);
    },
  );
}
