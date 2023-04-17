import 'reference_entity.dart';

class CreateBudgetData {
  const CreateBudgetData({
    required this.title,
    required this.amount,
    required this.description,
    required this.plans,
    required this.startedAt,
    required this.endedAt,
  });

  final String title;
  final int amount;
  final String description;
  final List<ReferenceEntity> plans;
  final DateTime startedAt;
  final DateTime? endedAt;
}
