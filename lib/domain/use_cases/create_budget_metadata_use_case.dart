import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/create_budget_metadata_data.dart';
import 'package:ovavue/domain/repositories/budget_metadata.dart';

class CreateBudgetMetadataUseCase {
  const CreateBudgetMetadataUseCase({
    required BudgetMetadataRepository metadata,
    required Analytics analytics,
  }) : _metadata = metadata,
       _analytics = analytics;

  final BudgetMetadataRepository _metadata;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetMetadataData metadata,
  }) {
    _analytics.log(AnalyticsEvent.createBudgetMetadata(userId)).ignore();
    return _metadata.create(userId, metadata);
  }
}
