import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state.dart';

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

class BudgetPlanProvider {
  @visibleForTesting
  const BudgetPlanProvider({
    required Future<UserEntity> Function() fetchUser,
    required CreateBudgetPlanUseCase createBudgetPlanUseCase,
    required UpdateBudgetPlanUseCase updateBudgetPlanUseCase,
    required DeleteBudgetPlanUseCase deleteBudgetPlanUseCase,
    required CreateBudgetAllocationUseCase createBudgetAllocationUseCase,
    required UpdateBudgetAllocationUseCase updateBudgetAllocationUseCase,
  })  : _updateBudgetAllocationUseCase = updateBudgetAllocationUseCase,
        _createBudgetAllocationUseCase = createBudgetAllocationUseCase,
        _deleteBudgetPlanUseCase = deleteBudgetPlanUseCase,
        _updateBudgetPlanUseCase = updateBudgetPlanUseCase,
        _createBudgetPlanUseCase = createBudgetPlanUseCase,
        _fetchUser = fetchUser;

  final Future<UserEntity> Function() _fetchUser;
  final CreateBudgetPlanUseCase _createBudgetPlanUseCase;
  final UpdateBudgetPlanUseCase _updateBudgetPlanUseCase;
  final DeleteBudgetPlanUseCase _deleteBudgetPlanUseCase;
  final CreateBudgetAllocationUseCase _createBudgetAllocationUseCase;
  final UpdateBudgetAllocationUseCase _updateBudgetAllocationUseCase;

  Future<String> create(CreateBudgetPlanData data) async {
    final String userId = (await _fetchUser()).id;
    return _createBudgetPlanUseCase(userId: userId, plan: data);
  }

  Future<bool> update(UpdateBudgetPlanData data) async => _updateBudgetPlanUseCase(data);

  Future<bool> delete(String path) async => _deleteBudgetPlanUseCase(path);

  Future<String> createAllocation(CreateBudgetAllocationData data) async {
    final String userId = (await _fetchUser()).id;
    return _createBudgetAllocationUseCase(userId: userId, allocation: data);
  }

  Future<bool> updateAllocation(UpdateBudgetAllocationData data) async => _updateBudgetAllocationUseCase(data);
}
