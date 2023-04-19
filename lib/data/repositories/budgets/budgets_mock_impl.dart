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
    return NormalizedBudgetEntity(
      id: id,
      path: '/budgets/$userId/$id',
      title: title ?? faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      amount: (faker.randomGenerator.decimal(min: 1) * 1e9).toInt(),
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
      (int index) {
        final DateTime startedAt = clock.monthsFromNow(index);
        return BudgetsMockImpl.generateNormalizedBudget(
          title: '${clock.now().year}.${index + 1}',
          userId: userId,
          plans: plans,
          startedAt: startedAt,
          endedAt: count == index + 1 ? null : startedAt.add(const Duration(minutes: 10000)),
        );
      },
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
  Future<bool> addPlan({required String userId, required String budgetId, required ReferenceEntity plan}) async {
    _budgets$.add(
      _budgets
        ..update(
          budgetId,
          (BudgetEntity prev) => prev.copyWith(
            plans: <ReferenceEntity>[...prev.plans.where((_) => _.id != plan.id), plan],
          ),
        ),
    );
    return true;
  }

  @override
  Future<bool> removePlan({required String path, required String planId}) async {
    final String id = _budgets.values.firstWhere((BudgetEntity element) => element.path == path).id;
    _budgets$.add(
      _budgets
        ..update(
          id,
          (BudgetEntity prev) => prev.copyWith(plans: prev.plans.where((_) => _.id != planId).toList(growable: false)),
        ),
    );
    return true;
  }

  @override
  Stream<BudgetEntityList> fetch(String userId) =>
      _budgets$.stream.map((Map<String, BudgetEntity> event) => event.values.toList());

  @override
  Stream<BudgetEntity> fetchActiveBudget(String userId) => _budgets$.stream.map(
        (Map<String, BudgetEntity> event) => event.values.toList(growable: false).firstWhere((_) => _.endedAt == null),
      );

  @override
  Stream<BudgetEntity> fetchOne({required String userId, required String budgetId}) =>
      _budgets$.stream.map((Map<String, BudgetEntity> event) => event[budgetId]!);
}

extension on BudgetEntity {
  BudgetEntity copyWith({
    String? id,
    String? path,
    String? title,
    int? amount,
    String? description,
    List<ReferenceEntity>? plans,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      BudgetEntity(
        id: id ?? this.id,
        path: path ?? this.path,
        title: title ?? this.title,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        plans: plans ?? this.plans,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  BudgetEntity update(UpdateBudgetData update) => copyWith(
        title: update.title,
        description: update.description,
        amount: update.amount,
        endedAt: update.endedAt,
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
