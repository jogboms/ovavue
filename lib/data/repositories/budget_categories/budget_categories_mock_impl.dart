import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

import '../auth/auth_mock_impl.dart';
import '../extensions.dart';

class BudgetCategoriesMockImpl implements BudgetCategoriesRepository {
  static BudgetCategoryEntity generateCategory({String? id, String? userId}) {
    id ??= faker.guid.guid();
    return BudgetCategoryEntity(
      id: id,
      path: '/categories/${userId ?? AuthMockImpl.id}/$id',
      title: faker.lorem.words(1).join(' '),
      description: faker.lorem.sentence(),
      color: faker.randomGenerator.integer(1000000) * 0xfffff,
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final Map<String, BudgetCategoryEntity> _categories = <String, BudgetCategoryEntity>{};

  final BehaviorSubject<Map<String, BudgetCategoryEntity>> _categories$ =
      BehaviorSubject<Map<String, BudgetCategoryEntity>>.seeded(_categories);

  BudgetCategoryEntityList seed(
    int count, {
    String? userId,
  }) {
    final BudgetCategoryEntityList items = BudgetCategoryEntityList.generate(
      count,
      (_) => BudgetCategoriesMockImpl.generateCategory(userId: userId),
    );
    _categories$.add(_categories..addAll(items.foldToMap((BudgetCategoryEntity element) => element.id)));
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetCategoryData category) async {
    final String id = faker.guid.guid();
    final BudgetCategoryEntity newTag = BudgetCategoryEntity(
      id: id,
      path: '/categories/$userId/$id',
      title: category.title,
      description: category.description,
      color: category.color,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _categories$.add(_categories..putIfAbsent(id, () => newTag));
    return id;
  }

  @override
  Future<bool> delete(String path) async {
    final String id = _categories.values.firstWhere((BudgetCategoryEntity element) => element.path == path).id;
    _categories$.add(_categories..remove(id));
    return true;
  }

  @override
  Stream<BudgetCategoryEntityList> fetch(String userId) =>
      _categories$.stream.map((Map<String, BudgetCategoryEntity> event) => event.values.toList());
}
