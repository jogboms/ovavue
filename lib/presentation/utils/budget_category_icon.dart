import 'package:flutter/material.dart';
import 'package:ovavue/presentation/constants.dart';

@immutable
class BudgetCategoryIcon {
  const BudgetCategoryIcon._(this.index, this.data);

  factory BudgetCategoryIcon.fromIndex(int index) {
    final icon = AppIcons.categoryIcons[index];
    if (icon == null) {
      return BudgetCategoryIcon._(0, AppIcons.categoryIcons[0]!);
    }
    return BudgetCategoryIcon._(index, icon);
  }

  static const excess = BudgetCategoryIcon._(-1, AppIcons.excessPlan);
  static final List<BudgetCategoryIcon> values = AppIcons.categoryIcons.entries
      .map((MapEntry<int, IconData> e) => BudgetCategoryIcon._(e.key, e.value))
      .toList(growable: false);

  final int index;
  final IconData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetCategoryIcon && runtimeType == other.runtimeType && index == other.index && data == other.data;

  @override
  int get hashCode => index.hashCode ^ data.hashCode;
}
