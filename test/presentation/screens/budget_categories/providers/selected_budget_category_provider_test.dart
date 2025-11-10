import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/presentation.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final dummyUser = UsersMockImpl.user;
  const categoryId = 'category-id';

  final expectedCategory = BudgetCategoriesMockImpl.generateCategory(id: categoryId);
  final expectedPlan = BudgetPlansMockImpl.generatePlan(category: expectedCategory);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetCategoryProvider', () {
    Future<BudgetCategoryState> createProviderStream() {
      final container = createProviderContainer(
        overrides: [
          userProvider.overrideWith((_) async => dummyUser),
          budgetCategoriesProvider.overrideWith(
            (_) => Stream<List<BudgetCategoryViewModel>>.value(
              [BudgetCategoryViewModel.fromEntity(expectedCategory)],
            ),
          ),
          budgetPlansProvider.overrideWith(
            (_) => Stream<List<BudgetPlanViewModel>>.value(
              [BudgetPlanViewModel.fromEntity(expectedPlan)],
            ),
          ),
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetCategoryProvider(categoryId).future);
    }

    test('should show selected category by id', () async {
      expect(
        createProviderStream(),
        completion(
          BudgetCategoryState(
            plans: [
              (BudgetPlanViewModel.fromEntity(expectedPlan), null),
            ],
            category: BudgetCategoryViewModel.fromEntity(expectedCategory),
            allocation: null,
            budget: null,
          ),
        ),
      );
    });
  });
}
