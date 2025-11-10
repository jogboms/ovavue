import 'package:ovavue/domain/analytics/analytics.dart';
import 'package:ovavue/domain/analytics/analytics_event.dart';
import 'package:ovavue/domain/entities/create_budget_allocation_data.dart';
import 'package:ovavue/domain/entities/create_budget_data.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/repositories/budget_allocations.dart';
import 'package:ovavue/domain/repositories/budgets.dart';

class CreateBudgetUseCase {
  const CreateBudgetUseCase({
    required BudgetsRepository budgets,
    required BudgetAllocationsRepository allocations,
    required Analytics analytics,
  }) : _budgets = budgets,
       _allocations = allocations,
       _analytics = analytics;

  final BudgetsRepository _budgets;
  final BudgetAllocationsRepository _allocations;
  final Analytics _analytics;

  Future<String> call({
    required String userId,
    required CreateBudgetData budget,
    required ReferenceEntity? activeBudgetReference,
    required PlanToAllocationMap? allocations,
  }) {
    _analytics.log(AnalyticsEvent.createBudget(userId)).ignore();
    return _budgets.create(userId, budget).then(
      (ReferenceEntity ref) async {
        await Future.wait(
          <Future<Object>>[
            if (activeBudgetReference != null)
              _budgets.deactivateBudget(
                reference: activeBudgetReference,
                endedAt: budget.startedAt,
              ),
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
