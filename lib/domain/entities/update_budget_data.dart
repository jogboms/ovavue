import 'package:equatable/equatable.dart';

class UpdateBudgetData with EquatableMixin {
  const UpdateBudgetData({
    required this.id,
    required this.path,
    required this.title,
    required this.amount,
    required this.description,
    required this.active,
    required this.startedAt,
    required this.endedAt,
  });

  final String id;
  final String path;
  final String title;
  final int amount;
  final String description;
  final bool active;
  final DateTime startedAt;
  final DateTime? endedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, amount, description, active, startedAt, endedAt];
}
