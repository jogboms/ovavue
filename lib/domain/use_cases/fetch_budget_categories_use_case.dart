import 'package:ovavue/domain/entities/budget_category_entity.dart';
import 'package:ovavue/domain/repositories/budget_categories.dart';

class FetchBudgetCategoriesUseCase {
  const FetchBudgetCategoriesUseCase({
    required BudgetCategoriesRepository categories,
  }) : _categories = categories;

  final BudgetCategoriesRepository _categories;

  Stream<BudgetCategoryEntityList> call(String userId) => _categories.fetchAll(userId);
}
