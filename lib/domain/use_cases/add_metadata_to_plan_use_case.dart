import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/reference_entity.dart';
import '../repositories/budget_metadata.dart';

class AddMetadataToPlanUseCase {
  const AddMetadataToPlanUseCase({
    required BudgetMetadataRepository metadata,
    required Analytics analytics,
  })  : _metadata = metadata,
        _analytics = analytics;

  final BudgetMetadataRepository _metadata;
  final Analytics _analytics;

  Future<bool> call({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) {
    _analytics.log(AnalyticsEvent.addMetadataToPlan(metadata.path)).ignore();
    return _metadata.addMetadataToPlan(userId: userId, plan: plan, metadata: metadata);
  }
}
