import 'package:flutter/material.dart';

import '../constants.dart';

class BudgetCategoryIcon {
  const BudgetCategoryIcon._(this.index, this.data);

  static const BudgetCategoryIcon excess = BudgetCategoryIcon._(-1, AppIcons.excessPlan);

  final int index;
  final IconData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetCategoryIcon && runtimeType == other.runtimeType && index == other.index && data == other.data;

  @override
  int get hashCode => index.hashCode ^ data.hashCode;

  static BudgetCategoryIcon fromIndex(int index) {
    final IconData? icon = AppIcons.categoryIcons[index];
    if (icon == null) {
      return BudgetCategoryIcon._(0, AppIcons.categoryIcons[0]!);
    }
    return BudgetCategoryIcon._(index, icon);
  }

  static final List<BudgetCategoryIcon> values =
      AppIcons.categoryIcons.entries.map((_) => BudgetCategoryIcon._(_.key, _.value)).toList(growable: false);
}
