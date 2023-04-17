import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class CreateBudgetAllocationData with EquatableMixin {
  const CreateBudgetAllocationData({
    required this.amount,
    required this.budget,
    required this.plan,
  });

  final int amount;
  final ReferenceEntity budget;
  final ReferenceEntity plan;

  @override
  List<Object?> get props => <Object?>[amount, budget, plan];
}
