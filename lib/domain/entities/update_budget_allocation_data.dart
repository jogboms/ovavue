import 'package:equatable/equatable.dart';

class UpdateBudgetAllocationData with EquatableMixin {
  const UpdateBudgetAllocationData({
    required this.id,
    required this.path,
    required this.amount,
  });

  final String id;
  final String path;
  final int amount;

  @override
  List<Object?> get props => <Object?>[id, path, amount];
}
