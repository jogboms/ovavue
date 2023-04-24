import '../analytics/analytics.dart';
import '../analytics/analytics_event.dart';
import '../entities/create_budget_allocation_data.dart';
import '../entities/create_budget_data.dart';
import '../entities/reference_entity.dart';
import '../repositories/budget_allocations.dart';
import '../repositories/budgets.dart';

class CreateBudgetUseCase {
  const CreateBudgetUseCase({
    required BudgetsRepository budgets,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  })  : _budgets = budgets,
        _allocations = allocations,
        _analytics = analytics;

  final BudgetsRepository _budgets;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetData budget,
    required String? activeBudgetPath,
    required PlanToAllocationMap? allocations,
  }) {
    _analytics.log(AnalyticsEvent.createBudget(userId)).ignore();
    return _budgets.create(userId, budget).then(
      (ReferenceEntity ref) async {
        await Future.wait(
          <Future<Object>>[
            if (activeBudgetPath != null)
              _budgets.deactivateBudget(budgetPath: activeBudgetPath, endedAt: budget.startedAt),
            if (allocations != null)
              _allocations.createAll(
                userId,
                allocations
                    .map(
                      (ReferenceEntity plan, int value) => MapEntry<String, CreateBudgetAllocationData>(
                        plan.id,
                        CreateBudgetAllocationData(
                          budget: ref,
                          plan: plan,
                          amount: value,
                        ),
                      ),
                    )
                    .values
                    .toList(growable: false),
              ),
          ],
        );

        return ref.id;
      },
    );
  }
}

typedef PlanToAllocationMap = Map<ReferenceEntity, int>;
