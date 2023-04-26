import 'package:flutter/material.dart';

class BudgetCategoryIcon {
  const BudgetCategoryIcon._(this.data);

  final IconData data;

  int get index => values.indexOf(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BudgetCategoryIcon && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;

  // TODO(Jogboms): introduce proper icons
  static const List<BudgetCategoryIcon> values = <BudgetCategoryIcon>[
    BudgetCategoryIcon._(Icons.add_chart),
    BudgetCategoryIcon._(Icons.add_box_outlined),
    BudgetCategoryIcon._(Icons.add_business_outlined),
    BudgetCategoryIcon._(Icons.add_card_outlined),
    BudgetCategoryIcon._(Icons.add_chart_outlined),
    BudgetCategoryIcon._(Icons.add_circle_outlined),
    BudgetCategoryIcon._(Icons.add_circle_outline_outlined),
    BudgetCategoryIcon._(Icons.add_comment_outlined),
    BudgetCategoryIcon._(Icons.add_home_outlined),
    BudgetCategoryIcon._(Icons.add_home_work_outlined),
    BudgetCategoryIcon._(Icons.add_ic_call_outlined),
    BudgetCategoryIcon._(Icons.add_link_outlined),
    BudgetCategoryIcon._(Icons.add_location_outlined),
    BudgetCategoryIcon._(Icons.add_location_alt_outlined),
    BudgetCategoryIcon._(Icons.add_moderator_outlined),
    BudgetCategoryIcon._(Icons.add_photo_alternate_outlined),
    BudgetCategoryIcon._(Icons.add_reaction_outlined),
    BudgetCategoryIcon._(Icons.add_road_outlined),
    BudgetCategoryIcon._(Icons.add_shopping_cart_outlined),
    BudgetCategoryIcon._(Icons.add_task_outlined),
  ];
}
