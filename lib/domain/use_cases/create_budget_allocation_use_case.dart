import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/create_budget_allocation_data.dart';
import 'package:ovavue/domain/repositories/budget_allocations.dart';

class CreateBudgetAllocationUseCase {
  const CreateBudgetAllocationUseCase({
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  }) : _allocations = allocations,
       _analytics = analytics;

  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetAllocationData allocation,
  }) {
    _analytics.log(AnalyticsEvent.createBudgetAllocation(userId)).ignore();
    return _allocations.create(userId, allocation);
  }
}
