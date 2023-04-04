import '../entities/budget_category_entity.dart';
import '../repositories/budget_categories.dart';

class FetchBudgetCategoriesUseCase {
  const FetchBudgetCategoriesUseCase({
    required BudgetCategoriesRepository categories,
  }) : _categories = categories;

  final BudgetCategoriesRepository _categories;

  Stream<BudgetCategoryEntityList> call(String userId) => _categories.fetch(userId);
}
