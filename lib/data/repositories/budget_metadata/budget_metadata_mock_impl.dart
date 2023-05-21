import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/rxdart.dart';

import '../auth/auth_mock_impl.dart';
import '../extensions.dart';

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

  static final Map<String, BudgetMetadataValueEntity> _metadata = <String, BudgetMetadataValueEntity>{};
  static final Map<String, BudgetMetadataKeyEntity> _metadataKeys = <String, BudgetMetadataKeyEntity>{};
  static final Map<String, BudgetMetadataAssociationEntity> _metadataAssociations =
      <String, BudgetMetadataAssociationEntity>{};

  static final BehaviorSubject<Map<String, BudgetMetadataValueEntity>> _metadata$ =
      BehaviorSubject<Map<String, BudgetMetadataValueEntity>>.seeded(_metadata);
  static final BehaviorSubject<Map<String, BudgetMetadataKeyEntity>> _metadataKeys$ =
      BehaviorSubject<Map<String, BudgetMetadataKeyEntity>>.seeded(_metadataKeys);
  static final BehaviorSubject<Map<String, BudgetMetadataAssociationEntity>> _metadataAssociations$ =
      BehaviorSubject<Map<String, BudgetMetadataAssociationEntity>>.seeded(_metadataAssociations);

  static final Stream<Map<String, BudgetMetadataValueEntity>> metadata$ = _metadata$.stream;

  BudgetMetadataValueEntityList seed(
    int count, {
    String? userId,
    BudgetMetadataKeyEntity Function(int)? keyBuilder,
  }) {
    final Map<String, BudgetMetadataKeyEntity> keys = <String, BudgetMetadataKeyEntity>{};
    final BudgetMetadataValueEntityList items = BudgetMetadataValueEntityList.generate(
      count,
      (int index) {
        final BudgetMetadataValueEntity value = BudgetMetadataMockImpl.generateMetadataValue(
          userId: userId,
          key: keyBuilder?.call(index),
        );
        keys[value.key.id] = value.key;
        return value;
      },
    );
    _metadata$.add(_metadata..addAll(items.foldToMap((_) => _.id)));
    _metadataKeys$.add(_metadataKeys..addAll(keys));
    return items;
  }

  BudgetMetadataAssociationEntityList seedAssociations(
    int count, {
    String? userId,
    required ReferenceEntity plan,
    required ReferenceEntity Function(int) metadataValueBuilder,
  }) {
    final BudgetMetadataAssociationEntityList items = BudgetMetadataAssociationEntityList.generate(
      count,
      (int index) => BudgetMetadataMockImpl.generateMetadataAssociation(
        plan: plan,
        metadata: metadataValueBuilder(index),
      ),
    );
    _metadataAssociations$.add(
      _metadataAssociations
        ..addAll(
          items.uniqueBy((_) => Object.hash(_.plan.id, _.metadata.id)).foldToMap((_) => _.id),
        ),
    );
    return items;
  }

  @override
  Future<String> create(String userId, CreateBudgetMetadataData metadata) async {
    final String id = faker.guid.guid();
    final BudgetMetadataKeyEntity newItem = BudgetMetadataKeyEntity(
      id: id,
      path: '/metadata-keys/$userId/$id',
      title: metadata.title,
      description: metadata.description,
      createdAt: clock.now(),
      updatedAt: null,
    );
    _metadataKeys$.add(_metadataKeys..putIfAbsent(id, () => newItem));

    final (Map<String, BudgetMetadataValueEntity>, Map<String, BudgetMetadataAssociationEntity>) data = _runOperations(
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
  Future<bool> deleteKey(ReferenceEntity reference) async {
    _metadata$.add(_metadata..remove(reference.id));
    _metadataAssociations$.add(
      _metadataAssociations
        ..removeWhere((_, BudgetMetadataAssociationEntity value) => value.metadata.id == reference.id),
    );
    return true;
  }

  @override
  Stream<BudgetMetadataValueEntityList> fetchAll(String userId) =>
      _metadata$.stream.map((Map<String, BudgetMetadataValueEntity> event) => event.values.toList());

  @override
  Stream<BudgetMetadataValueEntityList> fetchAllByPlan({
    required String userId,
    required String planId,
  }) {
    return CombineLatestStream.combine2(
      _metadata$.stream,
      _metadataAssociations$.map((_) => _.values.where((_) => _.plan.id == planId).foldToMap((_) => _.metadata.id)),
      (
        Map<String, BudgetMetadataValueEntity> metadata,
        Map<String, BudgetMetadataAssociationEntity> associations,
      ) =>
          associations.entries
              .map((_) => metadata[_.key])
              .whereType<BudgetMetadataValueEntity>()
              .toList(growable: false),
    );
  }

  @override
  Stream<List<ReferenceEntity>> fetchPlansByMetadata({
    required String userId,
    required String metadataId,
  }) =>
      _metadataAssociations$
          .map((_) => _.values.where((_) => _.metadata.id == metadataId).map((_) => _.plan).toList(growable: false));

  @override
  Future<bool> update(String userId, UpdateBudgetMetadataData metadata) async {
    _metadataKeys$.add(_metadataKeys..update(metadata.id, (BudgetMetadataKeyEntity prev) => prev.update(metadata)));

    final (Map<String, BudgetMetadataValueEntity>, Map<String, BudgetMetadataAssociationEntity>) data = _runOperations(
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
    final BudgetMetadataKeyEntity key = _metadataKeys[metadataId]!;
    final Map<String, BudgetMetadataValueEntity> values = Map<String, BudgetMetadataValueEntity>.of(_metadata);
    final Map<String, BudgetMetadataAssociationEntity> associations =
        Map<String, BudgetMetadataAssociationEntity>.of(_metadataAssociations);
    for (final BudgetMetadataValueOperation item in operations) {
      if (item is BudgetMetadataValueCreationOperation) {
        final String id = faker.guid.guid();
        final BudgetMetadataValueEntity newItem = BudgetMetadataValueEntity(
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
    final BudgetMetadataAssociationEntity association = generateMetadataAssociation(
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
    final String id = _metadataAssociations.values.firstWhere((_) => _.plan == plan && _.metadata == metadata).id;
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
