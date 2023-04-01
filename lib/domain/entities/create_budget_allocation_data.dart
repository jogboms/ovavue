import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class CreateBudgetAllocationData with EquatableMixin {
  const CreateBudgetAllocationData({
    required this.amount,
    required this.budget,
    required this.item,
    required this.startedAt,
    required this.endedAt,
  });

  final int amount;
  final ReferenceEntity budget;
  final ReferenceEntity item;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[amount, budget, item, startedAt, endedAt];
}
