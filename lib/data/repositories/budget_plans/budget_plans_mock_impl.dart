import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/rxdart.dart';

import '../auth/auth_mock_impl.dart';
import '../budget_categories/budget_categories_mock_impl.dart';
import '../extensions.dart';

class BudgetPlansMockImpl implements BudgetPlansRepository {
  static BudgetPlanEntity generatePlan({
    String? id,
    String? userId,
    BudgetCategoryEntity? category,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    return BudgetPlanEntity(
      id: id,
      path: '/plans/$userId/$id',
      title: faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      category: category ?? BudgetCategoriesMockImpl.generateCategory(userId: userId),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetPlanReferenceEntity> _plans = <String, BudgetPlanReferenceEntity>{};

  static final BehaviorSubject<Map<String, BudgetPlanReferenceEntity>> _plans$ =
      BehaviorSubject<Map<String, BudgetPlanReferenceEntity>>.seeded(_plans);

  static final Stream<Map<String, BudgetPlanEntity>> plans$ = _plans$.switchMap(
    (Map<String, BudgetPlanReferenceEntity> plans) => BudgetCategoriesMockImpl.categories$.map(
      (Map<String, BudgetCategoryEntity> categories) => plans.map(
        (String id, BudgetPlanReferenceEntity plan) => MapEntry<String, BudgetPlanEntity>(
          id,
          plan.normalize(categories.values),
        ),
      ),
    ),
  );

  BudgetPlanEntityList seed(int count, BudgetPlanEntity Function(int) builder) {
    final BudgetPlanEntityList items = BudgetPlanEntityList.generate(count, builder);
    _plans$.add(
      _plans
        ..addAll(
          items
              .map((BudgetPlanEntity element) => element.denormalize)
              .foldToMap((BudgetPlanReferenceEntity element) => element.id),
        ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetPlanData plan) async {
    final String id = faker.guid.guid();
    final BudgetPlanReferenceEntity newItem = BudgetPlanReferenceEntity(
      id: id,
      path: '/plans/$userId/$id',
      title: plan.title,
      description: plan.description,
      category: plan.category,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _plans$.add(_plans..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> update(UpdateBudgetPlanData plan) async {
    _plans$.add(_plans..update(plan.id, (BudgetPlanReferenceEntity prev) => prev.update(plan)));
    return true;
  }

  @override
  Future<bool> delete(ReferenceEntity reference) async {
    _plans$.add(_plans..remove(reference.id));
    return true;
  }

  @override
  Stream<BudgetPlanEntityList> fetchAll(String userId) =>
      plans$.map((Map<String, BudgetPlanEntity> event) => event.values.toList());

  @override
  Stream<BudgetPlanEntity> fetchOne({
    required String userId,
    required String planId,
  }) =>
      plans$.map((Map<String, BudgetPlanEntity> event) => event.values.firstWhere((_) => _.id == planId));

  @override
  Stream<BudgetPlanEntityList> fetchByCategory({
    required String userId,
    required String categoryId,
  }) =>
      plans$.map(
        (Map<String, BudgetPlanEntity> event) => event.values.where((_) => _.category.id == categoryId).toList(),
      );
}

extension on BudgetPlanReferenceEntity {
  BudgetPlanReferenceEntity update(UpdateBudgetPlanData update) => BudgetPlanReferenceEntity(
        id: id,
        path: path,
        title: update.title,
        description: update.description,
        category: (id: update.category.id, path: update.category.path),
        createdAt: createdAt,
        updatedAt: clock.now(),
      );

  BudgetPlanEntity normalize(Iterable<BudgetCategoryEntity> categories) => BudgetPlanEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        category: categories.firstWhere((BudgetCategoryEntity category) => this.category.id == category.id),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension on BudgetPlanEntity {
  BudgetPlanReferenceEntity get denormalize => BudgetPlanReferenceEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        category: (id: category.id, path: category.path),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
