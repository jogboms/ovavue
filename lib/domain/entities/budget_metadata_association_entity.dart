import 'package:equatable/equatable.dart';

import 'package:ovavue/domain/entities/reference_entity.dart';

class BudgetMetadataAssociationEntity with EquatableMixin {
  const BudgetMetadataAssociationEntity({
    required this.id,
    required this.path,
    required this.plan,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final ReferenceEntity plan;
  final ReferenceEntity metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, plan, metadata, createdAt, updatedAt];
}

typedef BudgetMetadataAssociationEntityList = List<BudgetMetadataAssociationEntity>;
