import 'dart:math';

import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:ovavue/data.dart';
import 'package:ovavue/domain.dart';

extension ListExtensions<T> on Iterable<T> {
  Map<String, T> foldToMap(String Function(T) keyBuilder) => fold(
        <String, T>{},
        (Map<String, T> previousValue, T element) => <String, T>{...previousValue, keyBuilder(element): element},
      );
}

extension RandomGeneratorExtensions on RandomGenerator {
  DateTime get dateTime {
    final DateTime now = clock.now();
    final int year = now.year;
    final int month = now.month;
    return DateTime(
      integer(year, min: year),
      integer(min(month + 1, 12), min: max(month - 1, 0)),
      integer(29, min: 1),
      integer(23),
      integer(59),
    );
  }
}

extension RandomEnum<T extends Object> on Iterable<T> {
  T random() => elementAt(Random().nextInt(length - 1));
}

void seedMockData() {
  final String userId = AuthMockImpl.id;
  final BudgetCategoryEntityList categories = BudgetCategoryEntityList.generate(
    10,
    (_) => BudgetCategoriesMockImpl.generateCategory(userId: userId),
  );
  final NormalizedBudgetPlanEntityList plans = NormalizedBudgetPlanEntityList.generate(
    25,
    (_) => BudgetPlansMockImpl.generateNormalizedPlan(userId: userId, category: categories.random()),
  );
  final NormalizedBudgetEntityList budgets = NormalizedBudgetEntityList.generate(
    5,
    (_) => BudgetsMockImpl.generateNormalizedBudget(userId: userId, plans: plans),
  );
  final NormalizedBudgetAllocationEntityList allocations = NormalizedBudgetAllocationEntityList.generate(
    250,
    (_) {
      final NormalizedBudgetPlanEntity plan = plans.random();
      return BudgetAllocationsMockImpl.generateNormalizedAllocation(
        userId: userId,
        budget: budgets.where((NormalizedBudgetEntity element) => element.plans.contains(plan)).random(),
        plan: plan,
      );
    },
  );

  BudgetCategoriesMockImpl().seed(categories);
  BudgetPlansMockImpl().seed(plans);
  BudgetsMockImpl().seed(budgets);
  BudgetAllocationsMockImpl().seed(allocations);
}
