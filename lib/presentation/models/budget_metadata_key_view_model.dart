import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

class BudgetMetadataKeyViewModel with EquatableMixin {
  const BudgetMetadataKeyViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetMetadataKeyViewModel fromEntity(BudgetMetadataKeyEntity entity) {
    return BudgetMetadataKeyViewModel(
      id: entity.id,
      path: entity.path,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, description, createdAt, updatedAt];
}
