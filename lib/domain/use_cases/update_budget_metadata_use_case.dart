import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/update_budget_metadata_data.dart';
import 'package:ovavue/domain/repositories/budget_metadata.dart';

class UpdateBudgetMetadataUseCase {
  const UpdateBudgetMetadataUseCase({
    required BudgetMetadataRepository metadata,
    required Analytics analytics,
  }) : _metadata = metadata,
       _analytics = analytics;

  final BudgetMetadataRepository _metadata;
  final Analytics _analytics;

  Future<bool> call({
    required String userId,
    required UpdateBudgetMetadataData metadata,
  }) {
    _analytics.log(AnalyticsEvent.updateBudgetMetadata(metadata.path)).ignore();
    return _metadata.update(userId, metadata);
  }
}
