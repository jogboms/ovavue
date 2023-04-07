import 'package:equatable/equatable.dart';

import '../utils.dart';

class BudgetAllocationViewModel with EquatableMixin {
  const BudgetAllocationViewModel({
    required this.id,
    required this.path,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final Money amount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, amount, createdAt, updatedAt];
}
