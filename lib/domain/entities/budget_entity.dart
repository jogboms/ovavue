import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class BudgetEntity with EquatableMixin {
  const BudgetEntity({
    required this.id,
    required this.path,
    required this.index,
    required this.title,
    required this.amount,
    required this.description,
    required this.active,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final int index;
  final String title;
  final int amount;
  final String description;
  final bool active;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props =>
      <Object?>[id, path, index, title, amount, description, active, startedAt, endedAt, createdAt, updatedAt];
}

typedef BudgetEntityList = List<BudgetEntity>;

extension BudgetEntityExtension on BudgetEntity {
  ReferenceEntity get reference => (id: id, path: path);
}
