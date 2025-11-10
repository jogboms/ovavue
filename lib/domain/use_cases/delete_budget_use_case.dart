import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/repositories/budgets.dart';

class DeleteBudgetUseCase {
  const DeleteBudgetUseCase({
    required BudgetsRepository budgets,
    required Analytics analytics,
  }) : _budgets = budgets,
       _analytics = analytics;

  final BudgetsRepository _budgets;
  final Analytics _analytics;

  Future<bool> call({
    required String id,
    required String path,
  }) {
    _analytics.log(AnalyticsEvent.deleteBudget(path)).ignore();
    return _budgets.delete((id: id, path: path));
  }
}
