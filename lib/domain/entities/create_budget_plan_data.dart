import 'package:equatable/equatable.dart';

import 'reference_entity.dart';

class CreateBudgetPlanData with EquatableMixin {
  const CreateBudgetPlanData({
    required this.title,
    required this.description,
    required this.category,
  });

  final String title;
  final String description;
  final ReferenceEntity category;

  @override
  List<Object?> get props => <Object?>[title, description, category];
}
