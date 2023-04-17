import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../state.dart';

part 'budget_category_provider.g.dart';

@riverpod
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
    required this.fetchUser,
    required this.createBudgetCategoryUseCase,
    required this.updateBudgetCategoryUseCase,
    required this.deleteBudgetCategoryUseCase,
  });

  final Future<UserEntity> Function() fetchUser;
  final CreateBudgetCategoryUseCase createBudgetCategoryUseCase;
  final UpdateBudgetCategoryUseCase updateBudgetCategoryUseCase;
  final DeleteBudgetCategoryUseCase deleteBudgetCategoryUseCase;

  Future<String> create(CreateBudgetCategoryData data) async {
    final String userId = (await fetchUser()).id;
    return createBudgetCategoryUseCase(userId: userId, category: data);
  }

  Future<bool> update(UpdateBudgetCategoryData data) async => updateBudgetCategoryUseCase(data);

  Future<bool> delete(String path) async => deleteBudgetCategoryUseCase(path);
}
