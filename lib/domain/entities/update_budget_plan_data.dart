import 'reference_entity.dart';

class UpdateBudgetPlanData {
  const UpdateBudgetPlanData({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.category,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final ReferenceEntity category;
}
