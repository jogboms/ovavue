class UpdateBudgetCategoryData {
  const UpdateBudgetCategoryData({
    required this.id,
    required this.path,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String id;
  final String path;
  final String title;
  final String description;
  final int icon;
  final int color;
}
