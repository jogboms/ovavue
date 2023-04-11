import 'package:equatable/equatable.dart';

class CreateBudgetCategoryData with EquatableMixin {
  const CreateBudgetCategoryData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final int icon;
  final int color;

  @override
  List<Object> get props => <Object>[title, description, icon, color];
}
