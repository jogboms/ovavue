import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/data/repositories/extensions.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/rxdart.dart';

class BudgetAllocationsMockImpl implements BudgetAllocationsRepository {
  static BudgetAllocationEntity generateAllocation({
    String? id,
    String? userId,
    int? amount,
    BudgetEntity? budget,
    BudgetPlanEntity? plan,
    DateTime? startedAt,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    startedAt ??= faker.randomGenerator.dateTime;
    return BudgetAllocationEntity(
      id: id,
      path: '/allocations/$userId/$id',
      amount: amount ?? faker.randomGenerator.integer(1000000),
      budget: budget ?? BudgetsMockImpl.generateBudget(userId: userId),
      plan: plan ?? BudgetPlansMockImpl.generatePlan(userId: userId),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final _allocations = <String, BudgetAllocationReferenceEntity>{};

  static final _allocations$ = BehaviorSubject<Map<String, BudgetAllocationReferenceEntity>>.seeded(_allocations);

  static final Stream<Map<String, BudgetAllocationEntity>> allocations$ = _allocations$.switchMap(
    (Map<String, BudgetAllocationReferenceEntity> allocations) => CombineLatestStream.combine2(
      BudgetsMockImpl.budgets$,
      BudgetPlansMockImpl.plans$,
      (Map<String, BudgetEntity> budgets, Map<String, BudgetPlanEntity> plans) => allocations.map(
        (String id, BudgetAllocationReferenceEntity allocation) => MapEntry<String, BudgetAllocationEntity>(
          id,
          allocation.normalize(
            budgets[allocation.budget.id]!,
            plans[allocation.plan.id]!,
          ),
        ),
      ),
    ),
  );

  BudgetAllocationEntityList seed(int count, BudgetAllocationEntity Function(int) builder) {
    final items = BudgetAllocationEntityList.generate(
      count,
      builder,
    );
    _allocations$.add(
      _allocations..addAll(
        items
            .uniqueBy((BudgetAllocationEntity e) => Object.hash(e.budget.id, e.plan.id))
            .map((BudgetAllocationEntity e) => e.denormalize)
            .foldToMap((BudgetAllocationReferenceEntity e) => e.id),
      ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetAllocationData allocation) async {
    final id = faker.guid.guid();
    final newItem = BudgetAllocationReferenceEntity(
      id: id,
      path: '/allocations/$userId/$id',
      amount: allocation.amount,
      budget: allocation.budget,
      plan: allocation.plan,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _allocations$.add(_allocations..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> createAll(String userId, List<CreateBudgetAllocationData> allocations) =>
      Future.wait(allocations.map((CreateBudgetAllocationData e) => create(userId, e))).then((_) => true);

  @override
  Future<bool> update(UpdateBudgetAllocationData allocation) async {
    _allocations$.add(_allocations..update(allocation.id, (BudgetAllocationReferenceEntity e) => e.update(allocation)));
    return true;
  }

  @override
  Future<bool> delete(ReferenceEntity reference) async {
    _allocations$.add(_allocations..remove(reference.id));
    return true;
  }

  @override
  Future<bool> deleteByPlan({
    required String userId,
    required String planId,
  }) async {
    _allocations$.add(_allocations..removeWhere((_, BudgetAllocationReferenceEntity e) => e.plan.id == planId));
    return true;
  }

  @override
  Stream<BudgetAllocationEntityList> fetchAll(String userId) => allocations$.map(
    (Map<String, BudgetAllocationEntity> event) => event.values.toList(),
  );

  @override
  Stream<BudgetAllocationEntityList> fetchByBudget({
    required String userId,
    required String budgetId,
  }) => allocations$.map(
    (Map<String, BudgetAllocationEntity> event) =>
        event.values.where((BudgetAllocationEntity e) => e.budget.id == budgetId).toList(),
  );

  @override
  Stream<BudgetAllocationEntity?> fetchOne({
    required String userId,
    required String budgetId,
    required String planId,
  }) => allocations$.map(
    (Map<String, BudgetAllocationEntity> event) => event.values.singleWhereOrNull(
      (BudgetAllocationEntity e) => e.budget.id == budgetId && e.plan.id == planId,
    ),
  );

  @override
  Stream<BudgetAllocationEntityList> fetchByPlan({
    required String userId,
    required String planId,
  }) => allocations$.map(
    (Map<String, BudgetAllocationEntity> event) =>
        event.values.where((BudgetAllocationEntity e) => e.plan.id == planId).toList(),
  );
}

extension on BudgetAllocationReferenceEntity {
  BudgetAllocationReferenceEntity update(UpdateBudgetAllocationData update) => BudgetAllocationReferenceEntity(
    id: id,
    path: path,
    amount: update.amount,
    budget: budget,
    plan: plan,
    createdAt: createdAt,
    updatedAt: clock.now(),
  );

  BudgetAllocationEntity normalize(BudgetEntity budget, BudgetPlanEntity plan) => BudgetAllocationEntity(
    id: id,
    path: path,
    amount: amount,
    budget: budget,
    plan: plan,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension on BudgetAllocationEntity {
  BudgetAllocationReferenceEntity get denormalize => BudgetAllocationReferenceEntity(
    id: id,
    path: path,
    amount: amount,
    budget: (id: budget.id, path: budget.path),
    plan: (id: plan.id, path: plan.path),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
