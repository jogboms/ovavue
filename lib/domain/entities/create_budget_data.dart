import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class CreateBudgetData with EquatableMixin {
  const CreateBudgetData({
    required this.title,
    required this.amount,
    required this.description,
    required this.items,
    required this.startedAt,
    required this.endedAt,
  });

  final String title;
  final int amount;
  final String description;
  final List<ReferenceEntity> items;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[title, amount, description, items, startedAt, endedAt];
}
