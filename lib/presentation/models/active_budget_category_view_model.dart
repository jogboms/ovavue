import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../utils.dart';

class ActiveBudgetCategoryViewModel with EquatableMixin {
  const ActiveBudgetCategoryViewModel({
    required this.id,
    required this.path,
    required this.title,
    required this.allocation,
    required this.description,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String path;
  final String title;
  final Money allocation;
  final String description;
  final Color color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, path, title, allocation, description, color, createdAt, updatedAt];
}
