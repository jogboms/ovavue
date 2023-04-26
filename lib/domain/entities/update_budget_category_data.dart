class UpdateBudgetCategoryData {
  const UpdateBudgetCategoryData({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.iconIndex,
    required this.colorSchemeIndex,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final int iconIndex;
  final int colorSchemeIndex;
}
