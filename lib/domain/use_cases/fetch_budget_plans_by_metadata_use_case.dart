import 'package:ovavue/core.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/budget_plan_entity.dart';
import '../repositories/budget_metadata.dart';
import '../repositories/budget_plans.dart';

class FetchBudgetPlansByMetadataUseCase {
  const FetchBudgetPlansByMetadataUseCase({
    required BudgetPlansRepository plans,
    required BudgetMetadataRepository metadata,
  })  : _plans = plans,
        _metadata = metadata;

  final BudgetPlansRepository _plans;
  final BudgetMetadataRepository _metadata;

  Stream<BudgetPlanEntityList> call({
    required String userId,
    required String metadataId,
  }) {
    return CombineLatestStream.combine2(
      _plans.fetchAll(userId),
      _metadata.fetchPlansByMetadata(userId: userId, metadataId: metadataId),
      (BudgetPlanEntityList plans, List<ReferenceEntity> references) {
        final Map<String, BudgetPlanEntity> plansById = plans.foldToMap((_) => _.id);
        return references.map((_) => plansById[_.id]).whereType<BudgetPlanEntity>().toList(growable: false);
      },
    );
  }
}
