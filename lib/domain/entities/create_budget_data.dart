import 'package:equatable/equatable.dart';

class CreateBudgetData with EquatableMixin {
  const CreateBudgetData({
    required this.index,
    required this.title,
    required this.amount,
    required this.description,
    required this.startedAt,
  });

  final int index;
  final String title;
  final int amount;
  final String description;
  final DateTime startedAt;

  @override
  List<Object?> get props => <Object?>[index, title, amount, description, startedAt];
}
