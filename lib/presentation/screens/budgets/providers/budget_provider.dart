import 'package:flutter/foundation.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import 'active_budget_provider.dart';

part 'budget_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, activeBudget, selectedBudget])
BudgetProvider budget(BudgetRef ref) {
  final RegistryFactory di = ref.read(registryProvider).get;

  return BudgetProvider(
    fetchUser: () => ref.read(userProvider.future),
    fetchActiveBudgetReference: () => ref.read(
      activeBudgetProvider.selectAsync(
        (BaseBudgetState state) => switch (state) {
          BudgetState() => (id: state.budget.id, path: state.budget.path),
          EmptyBudgetState() => null,
        },
      ),
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
                (id: element.id, path: element.path),
                () => amount,
              );
          },
        ),
      ),
    ),
    createBudgetUseCase: di(),
    activateBudgetUseCase: di(),
    updateBudgetUseCase: di(),
  );
}

class BudgetProvider {
  @visibleForTesting
  BudgetProvider({
    required AsyncValueGetter<UserEntity> fetchUser,
    required AsyncValueGetter<ReferenceEntity?> fetchActiveBudgetReference,
    required Future<PlanToAllocationMap> Function(String id) fetchBudgetAllocations,
    required CreateBudgetUseCase createBudgetUseCase,
    required ActivateBudgetUseCase activateBudgetUseCase,
    required UpdateBudgetUseCase updateBudgetUseCase,
  })  : _updateBudgetUseCase = updateBudgetUseCase,
        _activateBudgetUseCase = activateBudgetUseCase,
        _createBudgetUseCase = createBudgetUseCase,
        _fetchBudgetAllocations = fetchBudgetAllocations,
        _fetchActiveBudgetReference = fetchActiveBudgetReference,
        _fetchUser = fetchUser;

  final AsyncValueGetter<UserEntity> _fetchUser;
  final AsyncValueGetter<ReferenceEntity?> _fetchActiveBudgetReference;
  final Future<PlanToAllocationMap> Function(String id) _fetchBudgetAllocations;
  final CreateBudgetUseCase _createBudgetUseCase;
  final ActivateBudgetUseCase _activateBudgetUseCase;
  final UpdateBudgetUseCase _updateBudgetUseCase;

  Future<String> create({
    required String? fromBudgetId,
    required int index,
    required String title,
    required int amount,
    required String description,
    required DateTime startedAt,
    required DateTime? endedAt,
    required bool active,
  }) async {
    final String userId = (await _fetchUser()).id;
    final ReferenceEntity? activeBudgetReference = await _fetchActiveBudgetReference();
    final PlanToAllocationMap? allocations = fromBudgetId != null ? await _fetchBudgetAllocations(fromBudgetId) : null;

    return _createBudgetUseCase.call(
      userId: userId,
      activeBudgetReference: activeBudgetReference,
      allocations: allocations,
      budget: CreateBudgetData(
        index: index,
        title: title,
        amount: amount,
        description: description,
        active: active,
        startedAt: startedAt,
        endedAt: endedAt,
      ),
    );
  }

  Future<bool> activate({
    required String id,
    required String path,
  }) async {
    final String userId = (await _fetchUser()).id;
    final ReferenceEntity? activeBudgetReference = await _fetchActiveBudgetReference();

    return _activateBudgetUseCase.call(
      userId: userId,
      reference: (id: id, path: path),
      activeBudgetReference: activeBudgetReference,
    );
  }

  Future<bool> update({
    required String id,
    required String path,
    required String title,
    required int amount,
    required String description,
    required bool active,
    required DateTime startedAt,
    required DateTime? endedAt,
  }) async {
    return _updateBudgetUseCase.call(
      UpdateBudgetData(
        id: id,
        path: path,
        title: title,
        amount: amount,
        description: description,
        active: active,
        startedAt: startedAt,
        endedAt: endedAt,
      ),
    );
  }
}
