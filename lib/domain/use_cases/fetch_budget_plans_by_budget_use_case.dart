import '../entities/budget_allocation_entity.dart';
import '../entities/budget_plan_entity.dart';
import '../repositories/budget_allocations.dart';

class FetchBudgetPlansByBudgetUseCase {
  const FetchBudgetPlansByBudgetUseCase({
    required BudgetAllocationsRepository allocations,
  }) : _allocations = allocations;

  final BudgetAllocationsRepository _allocations;

  Stream<BudgetIdToPlansMap> call(String userId) => _allocations
      .fetchAll(userId)
      .map(
        (BudgetAllocationEntityList allocations) => allocations.fold(<String, Set<BudgetPlanEntity>>{}, (
          BudgetIdToPlansMap previousValue,
          BudgetAllocationEntity allocation,
        ) {
          final BudgetPlanEntity plan = allocation.plan;

          return previousValue
            ..update(
              allocation.budget.id,
              (Set<BudgetPlanEntity> plans) => <BudgetPlanEntity>{...plans, plan},
              ifAbsent: () => <BudgetPlanEntity>{plan},
            );
        }),
      )
      .distinct();
}

typedef BudgetIdToPlansMap = Map<String, Set<BudgetPlanEntity>>;
