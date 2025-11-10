import 'dart:math';

import 'package:ovavue/core.dart';
import 'package:ovavue/data/repositories/auth/auth_mock_impl.dart';
import 'package:ovavue/data/repositories/budget_allocations/budget_allocations_mock_impl.dart';
import 'package:ovavue/data/repositories/budget_categories/budget_categories_mock_impl.dart';
import 'package:ovavue/data/repositories/budget_metadata/budget_metadata_mock_impl.dart';
import 'package:ovavue/data/repositories/budget_plans/budget_plans_mock_impl.dart';
import 'package:ovavue/data/repositories/budgets/budgets_mock_impl.dart';
import 'package:ovavue/domain.dart';

void seedMockData() {
  final random = Random();
  final userId = AuthMockImpl.id;
  final categories = BudgetCategoriesMockImpl().seed(10, userId: userId);
  final plans = BudgetPlansMockImpl().seed(
    15,
    (_) => BudgetPlansMockImpl.generatePlan(userId: userId, category: categories.random()),
  );
  final metadataKeys = List<BudgetMetadataKeyEntity>.generate(
    5,
    (_) => BudgetMetadataMockImpl.generateMetadataKey(),
  );
  final metadataValues = BudgetMetadataMockImpl().seed(
    10,
    userId: userId,
    keyBuilder: (_) => metadataKeys.random(),
  );
  for (final plan in plans) {
    BudgetMetadataMockImpl().seedAssociations(
      max(random.nextInt(10), 1),
      plan: (id: plan.id, path: plan.path),
      metadataValueBuilder: (_) {
        final metadata = metadataValues.random();
        return (id: metadata.id, path: metadata.path);
      },
    );
  }
  final budgets = BudgetsMockImpl().seed(5, userId: userId);
  final budgetById = budgets.foldToMap((BudgetEntity e) => e.id);
  final budgetToAmount = budgetById.map(
    (String key, BudgetEntity value) => MapEntry<String, int>(key, value.amount),
  );

  final allocations = <BudgetAllocationEntity>[];
  final preferredAllocationCount = budgets.length * plans.length;
  for (var i = 0; i < preferredAllocationCount; i++) {
    final budgetId = budgetById.keys.random();
    final plan = plans.random();

    final budget = budgetToAmount[budgetId] ?? 0;
    final amount = random.nextInt(max(1, (budget * random.nextDouble()).toInt()));

    if (random.nextBool()) {
      continue;
    }

    budgetToAmount[budgetId] = max(0, budget - amount);

    allocations.add(
      BudgetAllocationsMockImpl.generateAllocation(
        userId: userId,
        amount: amount,
        budget: budgetById[budgetId],
        plan: plan,
      ),
    );
  }

  BudgetAllocationsMockImpl().seed(allocations.length, (int index) => allocations[index]);
}
