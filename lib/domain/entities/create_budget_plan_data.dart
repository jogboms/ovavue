import 'reference_entity.dart';

class CreateBudgetPlanData {
  const CreateBudgetPlanData({
    required this.title,
    required this.description,
    required this.category,
  });

  final String title;
  final String description;
  final ReferenceEntity category;
}
