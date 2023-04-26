class CreateBudgetCategoryData {
  const CreateBudgetCategoryData({
    required this.title,
    required this.description,
    required this.iconIndex,
    required this.colorSchemeIndex,
  });

  final String title;
  final String description;
  final int iconIndex;
  final int colorSchemeIndex;
}
