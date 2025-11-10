import 'package:ovavue/domain/entities/budget_metadata_value_entity.dart';
import 'package:ovavue/domain/entities/create_budget_metadata_data.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/entities/update_budget_metadata_data.dart';

abstract class BudgetMetadataRepository {
  Future<String> create(String userId, CreateBudgetMetadataData metadata);

  Future<bool> update(String userId, UpdateBudgetMetadataData metadata);

  Stream<BudgetMetadataValueEntityList> fetchAll(String userId);

  Stream<BudgetMetadataValueEntityList> fetchAllByPlan({
    required String userId,
    required String planId,
  });

  Stream<List<ReferenceEntity>> fetchPlansByMetadata({
    required String userId,
    required String metadataId,
  });

  Future<bool> addMetadataToPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  });

  Future<bool> removeMetadataFromPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  });
}
