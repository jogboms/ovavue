import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data/repositories/auth/auth_mock_impl.dart';
import 'package:ovavue/data/repositories/extensions.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/subjects.dart';

class BudgetCategoriesMockImpl implements BudgetCategoriesRepository {
  static BudgetCategoryEntity generateCategory({String? id, String? userId}) {
    id ??= faker.guid.guid();
    return BudgetCategoryEntity(
      id: id,
      path: '/categories/${userId ?? AuthMockImpl.id}/$id',
      title: faker.lorem.words(1).join(' '),
      description: faker.lorem.sentence(),
      iconIndex: faker.randomGenerator.integer(10),
      colorSchemeIndex: faker.randomGenerator.integer(10),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final _categories = <String, BudgetCategoryEntity>{};

  static final _categories$ = BehaviorSubject<Map<String, BudgetCategoryEntity>>.seeded(_categories);

  static final Stream<Map<String, BudgetCategoryEntity>> categories$ = _categories$.stream;

  BudgetCategoryEntityList seed(
    int count, {
    String? userId,
  }) {
    final items = BudgetCategoryEntityList.generate(
      count,
      (_) => BudgetCategoriesMockImpl.generateCategory(userId: userId),
    );
    _categories$.add(_categories..addAll(items.foldToMap((BudgetCategoryEntity element) => element.id)));
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetCategoryData category) async {
    final id = faker.guid.guid();
    final newTag = BudgetCategoryEntity(
      id: id,
      path: '/categories/$userId/$id',
      title: category.title,
      description: category.description,
      iconIndex: category.iconIndex,
      colorSchemeIndex: category.colorSchemeIndex,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _categories$.add(_categories..putIfAbsent(id, () => newTag));
    return id;
  }

  @override
  Future<bool> update(UpdateBudgetCategoryData category) async {
    _categories$.add(_categories..update(category.id, (BudgetCategoryEntity prev) => prev.update(category)));
    return true;
  }

  @override
  Future<bool> delete(ReferenceEntity reference) async {
    _categories$.add(_categories..remove(reference.id));
    return true;
  }

  @override
  Stream<BudgetCategoryEntityList> fetchAll(String userId) =>
      _categories$.stream.map((Map<String, BudgetCategoryEntity> event) => event.values.toList());
}

extension on BudgetCategoryEntity {
  BudgetCategoryEntity update(UpdateBudgetCategoryData update) => BudgetCategoryEntity(
    id: id,
    path: path,
    title: update.title,
    description: update.description,
    iconIndex: update.iconIndex,
    colorSchemeIndex: update.colorSchemeIndex,
    createdAt: createdAt,
    updatedAt: clock.now(),
  );
}
