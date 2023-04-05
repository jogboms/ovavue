import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

import '../auth/auth_mock_impl.dart';
import '../budget_plans/budget_plans_mock_impl.dart';
import '../extensions.dart';

class BudgetsMockImpl implements BudgetsRepository {
  static BudgetEntity generateBudget({
    String? id,
    String? userId,
    NormalizedBudgetPlanEntityList? plans,
    DateTime? startedAt,
  }) =>
      generateNormalizedBudget(id: id, userId: userId, plans: plans, startedAt: startedAt).denormalize;

  static NormalizedBudgetEntity generateNormalizedBudget({
    String? id,
    String? userId,
    NormalizedBudgetPlanEntityList? plans,
    DateTime? startedAt,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    startedAt ??= faker.randomGenerator.dateTime;
    return NormalizedBudgetEntity(
      id: id,
      path: '/budgets/$userId/$id',
      title: faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      amount: faker.randomGenerator.integer(1000000),
      startedAt: startedAt,
      endedAt: startedAt.add(const Duration(minutes: 10000)),
      plans: plans ??
          NormalizedBudgetPlanEntityList.generate(3, (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId)),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetEntity> budgets = <String, BudgetEntity>{};

  final BehaviorSubject<Map<String, BudgetEntity>> _budgets$ =
      BehaviorSubject<Map<String, BudgetEntity>>.seeded(budgets);

  void seed(NormalizedBudgetEntityList items) => _budgets$.add(
        budgets
          ..addAll(
            items
                .map((NormalizedBudgetEntity element) => element.denormalize)
                .foldToMap((BudgetEntity element) => element.id),
          ),
      );

  @override
  Future<String> create(String userId, CreateBudgetData budget) async {
    final String id = faker.guid.guid();
    final BudgetEntity newItem = BudgetEntity(
      id: id,
      path: '/budgets/$userId/$id',
      title: budget.title,
      description: budget.description,
      amount: budget.amount,
      startedAt: budget.startedAt,
      endedAt: budget.endedAt,
      plans: budget.plans,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _budgets$.add(budgets..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> delete(String path) async {
    final String id = budgets.values.firstWhere((BudgetEntity element) => element.path == path).id;
    _budgets$.add(budgets..remove(id));
    return true;
  }

  @override
  Stream<BudgetEntityList> fetch(String userId) =>
      _budgets$.stream.map((Map<String, BudgetEntity> event) => event.values.toList());

  @override
  Stream<BudgetEntity> fetchActiveBudget(String userId) => _budgets$.stream.map(
        (Map<String, BudgetEntity> event) => (event.values.toList(growable: false)..sort(_sortFn)).first,
      );
}

int _sortFn(BudgetEntity a, BudgetEntity b) => b.startedAt.compareTo(a.startedAt);

extension on NormalizedBudgetEntity {
  BudgetEntity get denormalize => BudgetEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        amount: amount,
        startedAt: startedAt,
        endedAt: endedAt,
        plans: plans.map((NormalizedBudgetPlanEntity element) => element.reference).toList(growable: false),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
