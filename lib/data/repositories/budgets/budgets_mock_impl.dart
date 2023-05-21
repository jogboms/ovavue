import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

import '../auth/auth_mock_impl.dart';
import '../extensions.dart';

class BudgetsMockImpl implements BudgetsRepository {
  static BudgetEntity generateBudget({
    String? id,
    int? index,
    String? title,
    String? userId,
    bool? active,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    startedAt ??= faker.randomGenerator.dateTime;
    return BudgetEntity(
      id: id,
      path: '/budgets/$userId/$id',
      index: index ?? faker.randomGenerator.integer(100, min: 1),
      title: title ?? faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      amount: (faker.randomGenerator.decimal(min: 1) * 1e9).toInt(),
      active: active ?? faker.randomGenerator.boolean(),
      startedAt: startedAt,
      endedAt: endedAt,
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetEntity> _budgets = <String, BudgetEntity>{};

  static final BehaviorSubject<Map<String, BudgetEntity>> _budgets$ =
      BehaviorSubject<Map<String, BudgetEntity>>.seeded(_budgets);

  static final Stream<Map<String, BudgetEntity>> budgets$ =
      _budgets$.map((_) => _.map(MapEntry<String, BudgetEntity>.new));

  BudgetEntityList seed(
    int count, {
    String? userId,
  }) {
    final BudgetEntityList items = BudgetEntityList.generate(
      count,
      (int index) {
        final DateTime startedAt = clock.monthsFromNow(index);
        final bool active = count == index + 1;
        return BudgetsMockImpl.generateBudget(
          index: index,
          title: '${clock.now().year}.${index + 1}',
          userId: userId,
          active: active,
          startedAt: startedAt,
          endedAt: active ? null : startedAt.add(const Duration(minutes: 10000)),
        );
      },
    );
    _budgets$.add(_budgets..addAll(items.foldToMap((_) => _.id)));
    return items;
  }

  @override
  Future<ReferenceEntity> create(String userId, CreateBudgetData budget) async {
    final String id = faker.guid.guid();
    final String path = '/budgets/$userId/$id';
    final BudgetEntity newItem = BudgetEntity(
      id: id,
      path: path,
      index: budget.index,
      title: budget.title,
      description: budget.description,
      amount: budget.amount,
      startedAt: budget.startedAt,
      active: budget.active,
      endedAt: budget.endedAt,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _budgets$.add(_budgets..putIfAbsent(id, () => newItem));
    return (id: id, path: path);
  }

  @override
  Future<bool> update(UpdateBudgetData budget) async {
    _budgets$.add(_budgets..update(budget.id, (BudgetEntity prev) => prev.update(budget)));
    return true;
  }

  @override
  Future<bool> delete(ReferenceEntity reference) async {
    _budgets$.add(_budgets..remove(reference.id));
    return true;
  }

  @override
  Stream<BudgetEntityList> fetchAll(String userId) =>
      budgets$.map((Map<String, BudgetEntity> event) => event.values.toList());

  @override
  Stream<BudgetEntity?> fetchActiveBudget(String userId) => budgets$.map(
        (Map<String, BudgetEntity> event) => event.values.toList(growable: false).firstWhereOrNull((_) => _.active),
      );

  @override
  Future<bool> activateBudget(ReferenceEntity reference) async {
    _budgets$.add(_budgets..update(reference.id, (_) => _.copyWith(active: true)));
    return true;
  }

  @override
  Future<bool> deactivateBudget({required ReferenceEntity reference, required DateTime? endedAt}) async {
    _budgets$.add(_budgets..update(reference.id, (_) => _.copyWith(active: false, endedAt: endedAt)));
    return true;
  }

  @override
  Stream<BudgetEntity> fetchOne({required String userId, required String budgetId}) =>
      budgets$.map((Map<String, BudgetEntity> event) => event[budgetId]!);
}

extension on BudgetEntity {
  BudgetEntity copyWith({
    String? id,
    String? path,
    int? index,
    String? title,
    int? amount,
    String? description,
    bool? active,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      BudgetEntity(
        id: id ?? this.id,
        path: path ?? this.path,
        index: index ?? this.index,
        title: title ?? this.title,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        active: active ?? this.active,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  BudgetEntity update(UpdateBudgetData update) => copyWith(
        title: update.title,
        description: update.description,
        amount: update.amount,
        active: update.active,
        startedAt: update.startedAt,
        endedAt: update.endedAt,
        updatedAt: clock.now(),
      );
}
