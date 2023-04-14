import 'package:equatable/equatable.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models.dart';
import '../../../state.dart';
import 'models.dart';

export 'models.dart';

part 'selected_budget_category_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user, budgetCategories])
Stream<BudgetCategoryState> selectedBudgetCategory(SelectedBudgetCategoryRef ref, String id) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  final List<BudgetCategoryViewModel> budgetCategories = await ref.watch(budgetCategoriesProvider.future);
  final BudgetCategoryViewModel category = budgetCategories.firstWhere((_) => _.id == id);

  yield* registry
      .get<FetchBudgetPlansByCategoryUseCase>()
      .call(userId: user.id, categoryId: id)
      .map(
        (NormalizedBudgetPlanEntityList plans) => BudgetCategoryState(
          category: category,
          plans: plans
              .map(
                (NormalizedBudgetPlanEntity element) => BudgetCategoryPlanViewModel(
                  id: element.id,
                  path: element.path,
                  title: element.title,
                  allocation: null,
                ),
              )
              .toList(growable: false),
        ),
      )
      .distinct();
}

class BudgetCategoryState with EquatableMixin {
  const BudgetCategoryState({
    required this.category,
    required this.plans,
  });

  final BudgetCategoryViewModel category;
  final List<BudgetCategoryPlanViewModel> plans;

  @override
  List<Object?> get props => <Object?>[category, plans];
}
