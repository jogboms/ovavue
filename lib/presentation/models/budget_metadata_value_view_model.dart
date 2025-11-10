import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

class BudgetMetadataValueViewModel with EquatableMixin {
  const BudgetMetadataValueViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.value,
    required this.key,
  });

  factory BudgetMetadataValueViewModel.fromEntity(BudgetMetadataValueEntity entity) => BudgetMetadataValueViewModel(
    id: entity.id,
    path: entity.path,
    title: entity.title,
    value: entity.value,
    key: (id: entity.key.id, path: entity.key.path),
  );

  final String id;
  final String path;
  final String title;
  final String value;
  final ReferenceEntity key;

  @override
  List<Object?> get props => <Object?>[id, path, title, value, key];
}
