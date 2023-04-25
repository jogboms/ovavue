class CreateBudgetData {
  const CreateBudgetData({
    required this.index,
    required this.title,
    required this.amount,
    required this.description,
    required this.startedAt,
    required this.endedAt,
  });

  final int index;
  final String title;
  final int amount;
  final String description;
  final DateTime startedAt;
  final DateTime? endedAt;
}
