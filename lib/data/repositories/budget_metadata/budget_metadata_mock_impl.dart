import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/data/repositories/auth/auth_mock_impl.dart';
import 'package:ovavue/data/repositories/extensions.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/rxdart.dart';

class BudgetMetadataMockImpl implements BudgetMetadataRepository {
  static BudgetMetadataValueEntity generateMetadataValue({
    String? id,
    String? userId,
    BudgetMetadataKeyEntity? key,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    return BudgetMetadataValueEntity(
      id: id,
      path: '/metadata-values/$userId/$id',
      title: faker.lorem.words(2).join(),
      value: faker.lorem.word(),
      key: key ?? generateMetadataKey(userId: userId),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static BudgetMetadataKeyEntity generateMetadataKey({
    String? id,
    String? userId,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    return BudgetMetadataKeyEntity(
      id: id,
      path: '/metadata-keys/$userId/$id',
      title: faker.lorem.words(2).join(' '),
      description: faker.lorem.sentence(),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static BudgetMetadataAssociationEntity generateMetadataAssociation({
    String? id,
    String? userId,
    ReferenceEntity? plan,
    ReferenceEntity? metadata,
  }) {
    id ??= faker.guid.guid();
    userId ??= AuthMockImpl.id;
    return BudgetMetadataAssociationEntity(
      id: id,
      path: '/metadata-associations/$userId/$id',
      plan: plan ?? (id: 'id', path: 'path'),
      metadata: metadata ?? (id: 'id', path: 'path'),
      createdAt: faker.randomGenerator.dateTime,
      updatedAt: clock.now(),
    );
  }

  static final _metadata = <String, BudgetMetadataValueEntity>{};
  static final _metadataKeys = <String, BudgetMetadataKeyEntity>{};
  static final _metadataAssociations = <String, BudgetMetadataAssociationEntity>{};

  static final _metadata$ = BehaviorSubject<Map<String, BudgetMetadataValueEntity>>.seeded(_metadata);
  static final _metadataKeys$ = BehaviorSubject<Map<String, BudgetMetadataKeyEntity>>.seeded(_metadataKeys);
  static final _metadataAssociations$ = BehaviorSubject<Map<String, BudgetMetadataAssociationEntity>>.seeded(
    _metadataAssociations,
  );

  static final Stream<Map<String, BudgetMetadataValueEntity>> metadata$ = _metadata$.stream;

  BudgetMetadataValueEntityList seed(
    int count, {
    String? userId,
    BudgetMetadataKeyEntity Function(int)? keyBuilder,
  }) {
    final keys = <String, BudgetMetadataKeyEntity>{};
    final items = BudgetMetadataValueEntityList.generate(
      count,
      (int index) {
        final value = BudgetMetadataMockImpl.generateMetadataValue(
          userId: userId,
          key: keyBuilder?.call(index),
        );
        keys[value.key.id] = value.key;
        return value;
      },
    );
    _metadata$.add(_metadata..addAll(items.foldToMap((BudgetMetadataValueEntity e) => e.id)));
    _metadataKeys$.add(_metadataKeys..addAll(keys));
    return items;
  }

  BudgetMetadataAssociationEntityList seedAssociations(
    int count, {
    String? userId,
    required ReferenceEntity plan,
    required ReferenceEntity Function(int) metadataValueBuilder,
  }) {
    final items = BudgetMetadataAssociationEntityList.generate(
      count,
      (int index) => BudgetMetadataMockImpl.generateMetadataAssociation(
        plan: plan,
        metadata: metadataValueBuilder(index),
      ),
    );
    _metadataAssociations$.add(
      _metadataAssociations..addAll(
        items
            .uniqueBy((BudgetMetadataAssociationEntity e) => Object.hash(e.plan.id, e.metadata.id))
            .foldToMap((BudgetMetadataAssociationEntity e) => e.id),
      ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetMetadataData metadata) async {
    final id = faker.guid.guid();
    final newItem = BudgetMetadataKeyEntity(
      id: id,
      path: '/metadata-keys/$userId/$id',
      title: metadata.title,
      description: metadata.description,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _metadataKeys$.add(_metadataKeys..putIfAbsent(id, () => newItem));

    final data = _runOperations(
      metadataId: id,
      operations: metadata.operations,
      userId: userId,
    );

    _metadata$.add(
      _metadata
        ..clear()
        ..addAll(data.$1),
    );

    _metadataAssociations$.add(
      _metadataAssociations
        ..clear()
        ..addAll(data.$2),
    );

    return id;
  }

  @override
  Stream<BudgetMetadataValueEntityList> fetchAll(String userId) =>
      _metadata$.stream.map((Map<String, BudgetMetadataValueEntity> event) => event.values.toList());

  @override
  Stream<BudgetMetadataValueEntityList> fetchAllByPlan({
    required String userId,
    required String planId,
  }) => CombineLatestStream.combine2(
    _metadata$.stream,
    _metadataAssociations$.map(
      (Map<String, BudgetMetadataAssociationEntity> e) => e.values
          .where((BudgetMetadataAssociationEntity e) => e.plan.id == planId)
          .foldToMap((BudgetMetadataAssociationEntity e) => e.metadata.id),
    ),
    (
      Map<String, BudgetMetadataValueEntity> metadata,
      Map<String, BudgetMetadataAssociationEntity> associations,
    ) => associations.entries
        .map((MapEntry<String, BudgetMetadataAssociationEntity> e) => metadata[e.key])
        .whereType<BudgetMetadataValueEntity>()
        .toList(growable: false),
  );

  @override
  Stream<List<ReferenceEntity>> fetchPlansByMetadata({
    required String userId,
    required String metadataId,
  }) => _metadataAssociations$.map(
    (Map<String, BudgetMetadataAssociationEntity> e) => e.values
        .where((BudgetMetadataAssociationEntity e) => e.metadata.id == metadataId)
        .map((BudgetMetadataAssociationEntity e) => e.plan)
        .toList(growable: false),
  );

  @override
  Future<bool> update(String userId, UpdateBudgetMetadataData metadata) async {
    _metadataKeys$.add(_metadataKeys..update(metadata.id, (BudgetMetadataKeyEntity prev) => prev.update(metadata)));

    final data = _runOperations(
      metadataId: metadata.id,
      operations: metadata.operations,
      userId: userId,
    );

    _metadata$.add(
      _metadata
        ..clear()
        ..addAll(data.$1),
    );

    _metadataAssociations$.add(
      _metadataAssociations
        ..clear()
        ..addAll(data.$2),
    );

    return true;
  }

  (Map<String, BudgetMetadataValueEntity>, Map<String, BudgetMetadataAssociationEntity>) _runOperations({
    required String metadataId,
    required String userId,
    required Set<BudgetMetadataValueOperation> operations,
  }) {
    final key = _metadataKeys[metadataId]!;
    final values = Map<String, BudgetMetadataValueEntity>.of(_metadata);
    final associations = Map<String, BudgetMetadataAssociationEntity>.of(
      _metadataAssociations,
    );
    for (final item in operations) {
      if (item is BudgetMetadataValueCreationOperation) {
        final id = faker.guid.guid();
        final newItem = BudgetMetadataValueEntity(
          id: id,
          path: '/metadata-values/$userId/$id',
          title: item.title,
          value: item.value,
          key: key,
          createdAt: clock.now(),
          updatedAt: null,
        );
        values.putIfAbsent(id, () => newItem);
      } else if (item is BudgetMetadataValueModificationOperation) {
        values.update(item.reference.id, (BudgetMetadataValueEntity prev) => prev.update(key, item));
      } else if (item is BudgetMetadataValueRemovalOperation) {
        values.remove(item.reference.id);
        associations.removeWhere((_, BudgetMetadataAssociationEntity value) => value.metadata.id == item.reference.id);
      }
    }
    return (values, associations);
  }

  @override
  Future<bool> addMetadataToPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) async {
    final association = generateMetadataAssociation(
      userId: userId,
      plan: plan,
      metadata: metadata,
    );
    _metadataAssociations$.add(_metadataAssociations..putIfAbsent(association.id, () => association));
    return true;
  }

  @override
  Future<bool> removeMetadataFromPlan({
    required String userId,
    required ReferenceEntity plan,
    required ReferenceEntity metadata,
  }) async {
    final id = _metadataAssociations.values
        .firstWhere((BudgetMetadataAssociationEntity e) => e.plan == plan && e.metadata == metadata)
        .id;
    _metadataAssociations$.add(_metadataAssociations..remove(id));
    return true;
  }
}

extension on BudgetMetadataKeyEntity {
  BudgetMetadataKeyEntity update(UpdateBudgetMetadataData update) => BudgetMetadataKeyEntity(
    id: id,
    path: path,
    title: update.title,
    description: update.description,
    createdAt: createdAt,
    updatedAt: clock.now(),
  );
}

extension on BudgetMetadataValueEntity {
  BudgetMetadataValueEntity update(BudgetMetadataKeyEntity key, BudgetMetadataValueModificationOperation update) =>
      BudgetMetadataValueEntity(
        id: id,
        path: path,
        key: key,
        title: update.title,
        value: update.value,
        createdAt: createdAt,
        updatedAt: clock.now(),
      );
}
