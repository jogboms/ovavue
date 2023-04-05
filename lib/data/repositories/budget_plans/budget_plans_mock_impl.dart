import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
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
    return NormalizedBudgetPlanEntity(
      id: id,
      path: '/plans/${userId ?? AuthMockImpl.id}/$id',
      title: faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      category: category ?? BudgetCategoriesMockImpl.categories.values.random(),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetPlanEntity> plans = (faker.randomGenerator.amount((_) => generatePlan(), 5, min: 3)
        ..sort((BudgetPlanEntity a, BudgetPlanEntity b) => b.createdAt.compareTo(a.createdAt)))
      .foldToMap((BudgetPlanEntity element) => element.id);

  final BehaviorSubject<Map<String, BudgetPlanEntity>> _plans$ =
      BehaviorSubject<Map<String, BudgetPlanEntity>>.seeded(plans);

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
    _plans$.add(plans..putIfAbsent(id, () => newItem));
    return id;
  }

  @override
  Future<bool> delete(String path) async {
    final String id = plans.values.firstWhere((BudgetPlanEntity element) => element.path == path).id;
    _plans$.add(plans..remove(id));
    return true;
  }

  @override
  Stream<BudgetPlanEntityList> fetch(String userId) =>
      _plans$.stream.map((Map<String, BudgetPlanEntity> event) => event.values.toList());
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
