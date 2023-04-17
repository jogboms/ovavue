import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
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
    String? title,
    String? userId,
    NormalizedBudgetPlanEntityList? plans,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    startedAt ??= faker.randomGenerator.dateTime;
    endedAt ??= startedAt.add(const Duration(minutes: 10000));
    return NormalizedBudgetEntity(
      id: id,
      path: '/budgets/$userId/$id',
      title: title ?? faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      amount: faker.randomGenerator.integer(1000000),
      startedAt: startedAt,
      endedAt: endedAt,
      plans: plans ??
          NormalizedBudgetPlanEntityList.generate(3, (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId)),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetEntity> _budgets = <String, BudgetEntity>{};

  final BehaviorSubject<Map<String, BudgetEntity>> _budgets$ =
      BehaviorSubject<Map<String, BudgetEntity>>.seeded(_budgets);

  NormalizedBudgetEntityList seed(
    int count, {
    String? userId,
    NormalizedBudgetPlanEntityList? plans,
  }) {
    final NormalizedBudgetEntityList items = NormalizedBudgetEntityList.generate(
      count,
      (int index) => BudgetsMockImpl.generateNormalizedBudget(
        title: '${clock.now().year}.${index + 1}',
        userId: userId,
        plans: plans,
        startedAt: clock.monthsFromNow(index),
      ),
    );
    _budgets$.add(
      _budgets
        ..addAll(
          items
              .map((NormalizedBudgetEntity element) => element.denormalize)
              .foldToMap((BudgetEntity element) => element.id),
        ),
    );
    return items;
  }

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
    _budgets$.add(_budgets..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> update(UpdateBudgetData budget) async {
    _budgets$.add(_budgets..update(budget.id, (BudgetEntity prev) => prev.update(budget)));
    return true;
  }

  @override
  Future<bool> delete(String path) async {
    final String id = _budgets.values.firstWhere((BudgetEntity element) => element.path == path).id;
    _budgets$.add(_budgets..remove(id));
    return true;
  }

  @override
  Stream<BudgetEntityList> fetch(String userId) =>
      _budgets$.stream.map((Map<String, BudgetEntity> event) => event.values.toList());

  @override
  Stream<BudgetEntity> fetchActiveBudget(String userId) => _budgets$.stream.map(
        (Map<String, BudgetEntity> event) => (event.values.toList(growable: false)..sort(_sortFn)).first,
      );

  @override
  Stream<BudgetEntity> fetchOne({required String userId, required String budgetId}) =>
      _budgets$.stream.map((Map<String, BudgetEntity> event) => event[budgetId]!);
}

int _sortFn(BudgetEntity a, BudgetEntity b) => b.startedAt.compareTo(a.startedAt);

extension on BudgetEntity {
  BudgetEntity update(UpdateBudgetData update) => BudgetEntity(
        id: id,
        path: path,
        title: update.title,
        description: update.description,
        amount: update.amount,
        startedAt: startedAt,
        endedAt: update.endedAt,
        plans: plans,
        createdAt: createdAt,
        updatedAt: clock.now(),
      );
}

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
