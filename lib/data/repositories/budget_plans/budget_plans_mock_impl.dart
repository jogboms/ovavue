import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

import '../auth/auth_mock_impl.dart';
import '../budget_categories/budget_categories_mock_impl.dart';
import '../extensions.dart';

class BudgetPlansMockImpl implements BudgetPlansRepository {
  static BudgetPlanEntity generatePlan({String? id, String? userId, BudgetCategoryEntity? category, DateTime? date}) =>
      generateNormalizedPlan(id: id, userId: userId, category: category).denormalize;

  static NormalizedBudgetPlanEntity generateNormalizedPlan({
    String? id,
    String? userId,
    BudgetCategoryEntity? category,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    return NormalizedBudgetPlanEntity(
      id: id,
      path: '/plans/$userId/$id',
      title: faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      category: category ?? BudgetCategoriesMockImpl.generateCategory(userId: userId),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetPlanEntity> _plans = <String, BudgetPlanEntity>{};

  final BehaviorSubject<Map<String, BudgetPlanEntity>> _plans$ =
      BehaviorSubject<Map<String, BudgetPlanEntity>>.seeded(_plans);

  NormalizedBudgetPlanEntityList seed(int count, NormalizedBudgetPlanEntity Function(int) builder) {
    final NormalizedBudgetPlanEntityList items = NormalizedBudgetPlanEntityList.generate(count, builder);
    _plans$.add(
      _plans
        ..addAll(
          items
              .map((NormalizedBudgetPlanEntity element) => element.denormalize)
              .foldToMap((BudgetPlanEntity element) => element.id),
        ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetPlanData plan) async {
    final String id = faker.guid.guid();
    final BudgetPlanEntity newItem = BudgetPlanEntity(
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
  Future<bool> delete(String path) async {
    final String id = _plans.values.firstWhere((BudgetPlanEntity element) => element.path == path).id;
    _plans$.add(_plans..remove(id));
    return true;
  }

  @override
  Stream<BudgetPlanEntityList> fetch(String userId) =>
      _plans$.stream.map((Map<String, BudgetPlanEntity> event) => event.values.toList());

  @override
  Stream<BudgetPlanEntityList> fetchByCategory({
    required String userId,
    required String categoryId,
  }) =>
      _plans$.stream.map(
        (Map<String, BudgetPlanEntity> event) =>
            event.values.where((BudgetPlanEntity element) => element.category.id == categoryId).toList(),
      );
}

extension on NormalizedBudgetPlanEntity {
  BudgetPlanEntity get denormalize => BudgetPlanEntity(
        id: id,
        path: path,
        title: title,
        description: description,
        category: category.reference,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
