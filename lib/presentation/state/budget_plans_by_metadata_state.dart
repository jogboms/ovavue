import 'package:equatable/equatable.dart';

import '../models.dart';
import '../utils.dart';

sealed class BaseBudgetPlansByMetadataState {
  static const BaseBudgetPlansByMetadataState empty = EmptyBudgetPlansByMetadataState();
}

class BudgetPlansByMetadataState with EquatableMixin implements BaseBudgetPlansByMetadataState {
  const BudgetPlansByMetadataState({
    required this.budget,
    required this.allocation,
    required this.key,
    required this.metadata,
    required this.plans,
  });

  final BudgetViewModel? budget;
  final Money? allocation;
  final BudgetMetadataKeyViewModel key;
  final BudgetMetadataValueViewModel metadata;
  final List<BudgetPlanViewModel> plans;

  @override
  List<Object?> get props => <Object?>[budget, allocation, key, metadata, plans];
}

class EmptyBudgetPlansByMetadataState implements BaseBudgetPlansByMetadataState {
  const EmptyBudgetPlansByMetadataState();
}
