import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String categoryId = 'category-id';

  final BudgetCategoryEntity expectedCategory = BudgetCategoriesMockImpl.generateCategory(id: categoryId);
  final BudgetPlanEntity expectedPlan = BudgetPlansMockImpl.generatePlan(category: expectedCategory);

  tearDown(mockUseCases.reset);

  group('SelectedBudgetCategoryProvider', () {
    Future<BudgetCategoryState> createProviderStream() {
      final ProviderContainer container = createProviderContainer(
        overrides: <Override>[
          userProvider.overrideWith((_) async => dummyUser),
          budgetCategoriesProvider.overrideWith(
            (_) => Stream<List<BudgetCategoryViewModel>>.value(
              <BudgetCategoryViewModel>[BudgetCategoryViewModel.fromEntity(expectedCategory)],
            ),
          ),
          budgetPlansProvider.overrideWith(
            (_) => Stream<List<BudgetPlanViewModel>>.value(
              <BudgetPlanViewModel>[BudgetPlanViewModel.fromEntity(expectedPlan)],
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
            plans: <BudgetCategoryPlanViewModel>[
              BudgetCategoryPlanViewModel(
                id: expectedPlan.id,
                path: expectedPlan.path,
                title: expectedPlan.title,
                description: expectedPlan.description,
                allocation: null,
              )
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
