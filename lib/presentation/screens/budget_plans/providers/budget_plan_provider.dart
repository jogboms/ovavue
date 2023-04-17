import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../state.dart';

part 'budget_plan_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
BudgetPlanProvider budgetPlan(BudgetPlanRef ref) {
  final RegistryFactory di = ref.read(registryProvider).get;

  return BudgetPlanProvider(
    fetchUser: () => ref.read(userProvider.future),
    createBudgetPlanUseCase: di(),
    updateBudgetPlanUseCase: di(),
    deleteBudgetPlanUseCase: di(),
    createBudgetAllocationUseCase: di(),
    updateBudgetAllocationUseCase: di(),
  );
}

@visibleForTesting
class BudgetPlanProvider {
  const BudgetPlanProvider({
    required this.fetchUser,
    required this.createBudgetPlanUseCase,
    required this.updateBudgetPlanUseCase,
    required this.deleteBudgetPlanUseCase,
    required this.createBudgetAllocationUseCase,
    required this.updateBudgetAllocationUseCase,
  });

  final Future<UserEntity> Function() fetchUser;
  final CreateBudgetPlanUseCase createBudgetPlanUseCase;
  final UpdateBudgetPlanUseCase updateBudgetPlanUseCase;
  final DeleteBudgetPlanUseCase deleteBudgetPlanUseCase;
  final CreateBudgetAllocationUseCase createBudgetAllocationUseCase;
  final UpdateBudgetAllocationUseCase updateBudgetAllocationUseCase;

  Future<String> create(CreateBudgetPlanData data) async {
    final String userId = (await fetchUser()).id;
    return createBudgetPlanUseCase(userId: userId, plan: data);
  }

  Future<bool> update(UpdateBudgetPlanData data) async => updateBudgetPlanUseCase(data);

  Future<bool> delete(String path) async => deleteBudgetPlanUseCase(path);

  Future<String> createAllocation(CreateBudgetAllocationData data) async {
    final String userId = (await fetchUser()).id;
    return createBudgetAllocationUseCase(userId: userId, allocation: data);
  }

  Future<bool> updateAllocation(UpdateBudgetAllocationData data) async => updateBudgetAllocationUseCase(data);
}
