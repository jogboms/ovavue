import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../utils.dart';

Future<void> main() async {
  final UserEntity dummyUser = UsersMockImpl.user;
  const String categoryId = 'category-id';

  final BudgetCategoryEntity expectedCategory = BudgetCategoriesMockImpl.generateCategory(id: categoryId);

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
        ],
      );

      addTearDown(container.dispose);
      return container.read(selectedBudgetCategoryProvider(categoryId).future);
    }

    test('should show selected category by id', () async {
      final List<NormalizedBudgetPlanEntity> plans = <NormalizedBudgetPlanEntity>[
        BudgetPlansMockImpl.generateNormalizedPlan(category: expectedCategory),
      ];

      when(
        () => mockUseCases.fetchBudgetPlansByCategoryUseCase
            .call(userId: any(named: 'userId'), categoryId: any(named: 'categoryId')),
      ).thenAnswer((_) => Stream<NormalizedBudgetPlanEntityList>.value(plans));

      expect(
        createProviderStream(),
        completion(
          BudgetCategoryState(
            plans: plans
                .map(
                  (NormalizedBudgetPlanEntity plan) => BudgetCategoryPlanViewModel(
                    id: plan.id,
                    path: plan.path,
                    title: plan.title,
                    description: plan.description,
                    allocation: null,
                  ),
                )
                .toList(),
            category: BudgetCategoryViewModel.fromEntity(expectedCategory),
            allocation: null,
            budget: null,
          ),
        ),
      );
    });
  });
}
