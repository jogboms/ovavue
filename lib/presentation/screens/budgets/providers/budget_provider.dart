import 'package:flutter/foundation.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import 'active_budget_id_provider.dart';
import 'active_budget_provider.dart';

part 'budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, activeBudget, selectedBudget])
BudgetProvider budget(BudgetRef ref) {
  final RegistryFactory di = ref.read(registryProvider).get;

  return BudgetProvider(
    fetchUser: () => ref.read(userProvider.future),
    fetchActiveBudgetPath: () => ref.read(
      activeBudgetProvider.selectAsync((BaseBudgetState state) {
        if (state is BudgetState) {
          return state.budget.path;
        }
        return null;
      }),
    ),
    fetchBudgetAllocations: (String id) => ref.read(
      selectedBudgetProvider(id).selectAsync(
        (BudgetState data) => data.plans.fold(
          <ReferenceEntity, int>{},
          (PlanToAllocationMap previousValue, BudgetPlanViewModel element) {
            final int? amount = element.allocation?.amount.rawValue;
            if (amount == null) {
              return previousValue;
            }

            return previousValue
              ..putIfAbsent(
                ReferenceEntity(id: element.id, path: element.path),
                () => amount,
              );
          },
        ),
      ),
    ),
    createBudgetUseCase: di(),
    updateBudgetUseCase: di(),
  );
}

class BudgetProvider {
  @visibleForTesting
  BudgetProvider({
    required AsyncValueGetter<UserEntity> fetchUser,
    required AsyncValueGetter<String?> fetchActiveBudgetPath,
    required Future<PlanToAllocationMap> Function(String id) fetchBudgetAllocations,
    required CreateBudgetUseCase createBudgetUseCase,
    required UpdateBudgetUseCase updateBudgetUseCase,
  })  : _updateBudgetUseCase = updateBudgetUseCase,
        _createBudgetUseCase = createBudgetUseCase,
        _fetchBudgetAllocations = fetchBudgetAllocations,
        _fetchActiveBudgetPath = fetchActiveBudgetPath,
        _fetchUser = fetchUser;

  final AsyncValueGetter<UserEntity> _fetchUser;
  final AsyncValueGetter<String?> _fetchActiveBudgetPath;
  final Future<PlanToAllocationMap> Function(String id) _fetchBudgetAllocations;
  final CreateBudgetUseCase _createBudgetUseCase;
  final UpdateBudgetUseCase _updateBudgetUseCase;

  Future<String> create({
    required String? fromBudgetId,
    required int index,
    required String title,
    required int amount,
    required String description,
    required DateTime startedAt,
    required bool active,
  }) async {
    final String userId = (await _fetchUser()).id;
    final String? activeBudgetPath = await _fetchActiveBudgetPath();
    final PlanToAllocationMap? allocations = fromBudgetId != null ? await _fetchBudgetAllocations(fromBudgetId) : null;

    return _createBudgetUseCase.call(
      userId: userId,
      activeBudgetPath: activeBudgetPath,
      allocations: allocations,
      budget: CreateBudgetData(
        index: index,
        title: title,
        amount: amount,
        description: description,
        startedAt: startedAt,
      ),
    );
  }

  Future<bool> update({
    required String id,
    required String path,
    required String title,
    required int amount,
    required String description,
  }) async {
    return _updateBudgetUseCase.call(
      UpdateBudgetData(
        id: id,
        path: path,
        title: title,
        amount: amount,
        description: description,
        endedAt: null,
      ),
    );
  }
}
