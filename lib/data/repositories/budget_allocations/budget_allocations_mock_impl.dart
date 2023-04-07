import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

import '../auth/auth_mock_impl.dart';
import '../budget_plans/budget_plans_mock_impl.dart';
import '../budgets/budgets_mock_impl.dart';
import '../extensions.dart';

class BudgetAllocationsMockImpl implements BudgetAllocationsRepository {
  static BudgetAllocationEntity generateAllocation({
    String? id,
    String? userId,
    NormalizedBudgetEntity? budget,
    NormalizedBudgetPlanEntity? plan,
    DateTime? startedAt,
  }) =>
      generateNormalizedAllocation(
        id: id,
        userId: userId,
        budget: budget,
        plan: plan,
        startedAt: startedAt,
      ).denormalize;

  static NormalizedBudgetAllocationEntity generateNormalizedAllocation({
    String? id,
    String? userId,
    NormalizedBudgetEntity? budget,
    NormalizedBudgetPlanEntity? plan,
    DateTime? startedAt,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    startedAt ??= faker.randomGenerator.dateTime;
    return NormalizedBudgetAllocationEntity(
      id: id,
      path: '/allocations/$userId/$id',
      amount: faker.randomGenerator.integer(1000000),
      startedAt: startedAt,
      endedAt: startedAt.add(const Duration(minutes: 10000)),
      budget: budget ?? BudgetsMockImpl.generateNormalizedBudget(userId: userId),
      plan: plan ?? BudgetPlansMockImpl.generateNormalizedPlan(userId: userId),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetAllocationEntity> _allocations = <String, BudgetAllocationEntity>{};

  final BehaviorSubject<Map<String, BudgetAllocationEntity>> _allocations$ =
      BehaviorSubject<Map<String, BudgetAllocationEntity>>.seeded(_allocations);

  NormalizedBudgetAllocationEntityList seed(int count, NormalizedBudgetAllocationEntity Function(int) builder) {
    final NormalizedBudgetAllocationEntityList items = NormalizedBudgetAllocationEntityList.generate(count, builder);
    _allocations$.add(
      _allocations
        ..addAll(
          items
              .uniqueBy((NormalizedBudgetAllocationEntity element) => Object.hash(element.budget.id, element.plan.id))
              .map((NormalizedBudgetAllocationEntity element) => element.denormalize)
              .foldToMap((BudgetAllocationEntity element) => element.id),
        ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetAllocationData allocation) async {
    final String id = faker.guid.guid();
    final BudgetAllocationEntity newItem = BudgetAllocationEntity(
      id: id,
      path: '/allocations/$userId/$id',
      amount: allocation.amount,
      startedAt: allocation.startedAt,
      endedAt: allocation.endedAt,
      budget: allocation.budget,
      plan: allocation.plan,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _allocations$.add(_allocations..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> delete(String path) async {
    final String id = _allocations.values.firstWhere((BudgetAllocationEntity element) => element.path == path).id;
    _allocations$.add(_allocations..remove(id));
    return true;
  }

  @override
  Stream<BudgetAllocationEntityList> fetch({
    required String userId,
    required String budgetId,
    String? planId,
  }) =>
      _allocations$.stream.map(
        (Map<String, BudgetAllocationEntity> event) => event.values
            .where(
              (BudgetAllocationEntity element) =>
                  element.budget.id == budgetId && (planId == null ? true : element.plan.id == planId),
            )
            .toList(),
      );
}

extension on NormalizedBudgetAllocationEntity {
  BudgetAllocationEntity get denormalize => BudgetAllocationEntity(
        id: id,
        path: path,
        amount: amount,
        startedAt: startedAt,
        endedAt: endedAt,
        budget: budget.reference,
        plan: plan.reference,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
