import 'reference_entity.dart';

class CreateBudgetAllocationData {
  const CreateBudgetAllocationData({
    required this.amount,
    required this.budget,
    required this.plan,
  });

  final int amount;
  final ReferenceEntity budget;
  final ReferenceEntity plan;
}
