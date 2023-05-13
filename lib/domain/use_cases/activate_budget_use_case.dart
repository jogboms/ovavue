import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/reference_entity.dart';
import '../repositories/budgets.dart';

class ActivateBudgetUseCase {
  const ActivateBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  })  : _budgets = budgets,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<bool> call({
    required String userId,
    required ReferenceEntity reference,
    required ReferenceEntity? activeBudgetReference,
  }) {
    _analytics.log(AnalyticsEvent.activateBudget(reference.path)).ignore();
    return Future.wait(
      <Future<Object>>[
        if (activeBudgetReference != null)
          _budgets.deactivateBudget(
            reference: activeBudgetReference,
            endedAt: null,
          ),
        _budgets.activateBudget(reference),
      ],
    ).then((_) => true);
  }
}
