import 'package:equatable/equatable.dart';

class CreateBudgetData with EquatableMixin {
  const CreateBudgetData({
    required this.index,
    required this.title,
    required this.amount,
    required this.description,
    required this.active,
    required this.startedAt,
    required this.endedAt,
  });

  final int index;
  final String title;
  final int amount;
  final String description;
  final bool active;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[index, title, amount, description, active, startedAt, endedAt];
}
