import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class CreateBudgetItemData with EquatableMixin {
  const CreateBudgetItemData({
    required this.title,
    required this.description,
    required this.category,
    required this.startedAt,
    required this.endedAt,
  });

  final String title;
  final String description;
  final ReferenceEntity category;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[title, description, category, startedAt, endedAt];
}
