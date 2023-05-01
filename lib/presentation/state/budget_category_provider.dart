import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'account_provider.dart';
import 'registry_provider.dart';
import 'user_provider.dart';

part 'budget_category_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
BudgetCategoryProvider budgetCategory(BudgetCategoryRef ref) {
  final RegistryFactory di = ref.read(registryProvider).get;

  return BudgetCategoryProvider(
    fetchUser: () => ref.read(userProvider.future),
    createBudgetCategoryUseCase: di(),
    updateBudgetCategoryUseCase: di(),
    deleteBudgetCategoryUseCase: di(),
  );
}

@visibleForTesting
class BudgetCategoryProvider {
  const BudgetCategoryProvider({
    required AsyncValueGetter<UserEntity> fetchUser,
    required CreateBudgetCategoryUseCase createBudgetCategoryUseCase,
    required UpdateBudgetCategoryUseCase updateBudgetCategoryUseCase,
    required DeleteBudgetCategoryUseCase deleteBudgetCategoryUseCase,
  })  : _deleteBudgetCategoryUseCase = deleteBudgetCategoryUseCase,
        _updateBudgetCategoryUseCase = updateBudgetCategoryUseCase,
        _createBudgetCategoryUseCase = createBudgetCategoryUseCase,
        _fetchUser = fetchUser;

  final AsyncValueGetter<UserEntity> _fetchUser;
  final CreateBudgetCategoryUseCase _createBudgetCategoryUseCase;
  final UpdateBudgetCategoryUseCase _updateBudgetCategoryUseCase;
  final DeleteBudgetCategoryUseCase _deleteBudgetCategoryUseCase;

  Future<String> create(CreateBudgetCategoryData data) async {
    final String userId = (await _fetchUser()).id;
    return _createBudgetCategoryUseCase(userId: userId, category: data);
  }

  Future<bool> update(UpdateBudgetCategoryData data) async => _updateBudgetCategoryUseCase(data);

  Future<bool> delete(ReferenceEntity reference) async => _deleteBudgetCategoryUseCase(reference);
}
