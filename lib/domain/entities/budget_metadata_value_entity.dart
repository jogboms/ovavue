import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'budget_metadata_key_entity.dart';
import 'reference_entity.dart';

@visibleForTesting
class BaseBudgetMetadataValueEntity<K> with EquatableMixin {
  const BaseBudgetMetadataValueEntity({
    required this.id,
    required this.path,
    required this.title,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final K key;
  final String value;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, key, value, createdAt, updatedAt];
}

typedef BudgetMetadataValueReferenceEntity = BaseBudgetMetadataValueEntity<ReferenceEntity>;
typedef BudgetMetadataValueEntity = BaseBudgetMetadataValueEntity<BudgetMetadataKeyEntity>;

typedef BudgetMetadataValueReferenceEntityList = List<BudgetMetadataValueReferenceEntity>;
typedef BudgetMetadataValueEntityList = List<BudgetMetadataValueEntity>;
