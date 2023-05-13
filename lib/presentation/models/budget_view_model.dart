import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';

import '../utils.dart';

class BudgetViewModel with EquatableMixin {
  const BudgetViewModel({
    required this.id,
    required this.title,
    required this.path,
    required this.index,
    required this.amount,
    required this.description,
    required this.active,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  static BudgetViewModel fromEntity(BudgetEntity entity) {
    return BudgetViewModel(
      id: entity.id,
      title: entity.title,
      index: entity.index,
      path: entity.path,
      amount: entity.amount.asMoney,
      description: entity.description,
      active: entity.active,
      startedAt: entity.startedAt,
      endedAt: entity.endedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  final String id;
  final String path;
  final int index;
  final String title;
  final Money amount;
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
