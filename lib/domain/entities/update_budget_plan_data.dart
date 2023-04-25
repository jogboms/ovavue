class UpdateBudgetPlanData {
  const UpdateBudgetPlanData({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.categoryPath,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final String categoryId;
  final String categoryPath;
}
