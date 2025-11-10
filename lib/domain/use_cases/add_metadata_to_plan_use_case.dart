import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/repositories/budget_metadata.dart';

class AddMetadataToPlanUseCase {
  const AddMetadataToPlanUseCase({
    required BudgetMetadataRepository metadata,
    required Analytics analytics,
  }) : _metadata = metadata,
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
