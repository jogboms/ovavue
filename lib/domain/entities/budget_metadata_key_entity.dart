import 'package:equatable/equatable.dart';

class BudgetMetadataKeyEntity with EquatableMixin {
  const BudgetMetadataKeyEntity({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, createdAt, updatedAt];
}

typedef BudgetMetadataKeyEntityList = List<BudgetMetadataKeyEntity>;
