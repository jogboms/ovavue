import 'package:ovavue/domain.dart';

import '../../local_database.dart';

class BudgetMetadataLocalImpl implements BudgetMetadataRepository {
  const BudgetMetadataLocalImpl(this._db);

  final Database _db;

  @override
  Future<String> create(String userId, CreateBudgetMetadataData metadata) {
    print(_db);
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteKey(ReferenceEntity reference) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<BudgetMetadataValueEntityList> fetchAll(String userId) {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<bool> update(String userId, UpdateBudgetMetadataData metadata) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<BudgetMetadataValueEntityList> fetchAllByPlan({
    required String userId,
    required String planId,
  }) {
    // TODO: implement fetchAllByPlan
    throw UnimplementedError();
  }

  @override
  Stream<List<ReferenceEntity>> fetchPlansByMetadata({
    required String userId,
    required String metadataId,
  }) {
    // TODO: implement fetchPlansByMetadata
    throw UnimplementedError();
  }

  @override
  Future<bool> addMetadataToPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) {
    // TODO: implement addMetadataToPlan
    throw UnimplementedError();
  }

  @override
  Future<bool> removeMetadataFromPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) {
    // TODO: implement removeMetadataFromPlan
    throw UnimplementedError();
  }
}
