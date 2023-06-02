import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class BudgetMetadataLocalImpl implements BudgetMetadataRepository {
  const BudgetMetadataLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetMetadataData metadata) =>
      _db.budgetMetadataDao.createMetadata(metadata);

  @override
  Stream<BudgetMetadataValueEntityList> fetchAll(String userId) => _db.budgetMetadataDao.watchAllBudgetMetadataValues();

  @override
  Future<bool> update(String userId, UpdateBudgetMetadataData metadata) =>
      _db.budgetMetadataDao.updateMetadata(metadata);

  @override
  Stream<BudgetMetadataValueEntityList> fetchAllByPlan({
    required String userId,
    required String planId,
  }) =>
      _db.budgetMetadataDao.watchAllBudgetMetadataValuesByPlan(planId);

  @override
  Stream<List<ReferenceEntity>> fetchPlansByMetadata({
    required String userId,
    required String metadataId,
  }) =>
      _db.budgetMetadataDao.watchAllBudgetPlansByMetadata(metadataId);

  @override
  Future<bool> addMetadataToPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) =>
      _db.budgetMetadataDao.addMetadataToPlan(plan: plan, metadata: metadata);

  @override
  Future<bool> removeMetadataFromPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) =>
      _db.budgetMetadataDao.removeMetadataFromPlan(plan: plan, metadata: metadata);
}
