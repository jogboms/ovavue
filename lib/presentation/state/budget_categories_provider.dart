import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:ovavue/presentation/state/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_categories_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetCategoryViewModel>> budgetCategories(BudgetCategoriesRef ref) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetCategoriesUseCase>()
      .call(user.id)
      .map((BudgetCategoryEntityList e) => e.map(BudgetCategoryViewModel.fromEntity).toList(growable: false));
}
