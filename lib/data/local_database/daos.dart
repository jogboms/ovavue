part of 'database.dart';

@DriftAccessor(tables: <Type>[Accounts])
class AccountsDao extends DatabaseAccessor<Database> with _$AccountsDaoMixin {
  AccountsDao(super.db);

  Future<AccountEntity> getOrCreateSingleAccount(String? id) async {
    if (id == null) {
      return into(accounts).insertReturning(AccountsCompanion.insert()).then((_) => _.toEntity());
    }

    return (select(accounts)..where((_) => _.id.equals(id))).getSingleOrNull().then((AccountDataModel? account) {
      if (account == null) {
        return getOrCreateSingleAccount(null);
      }
      return account.toEntity();
    });
  }
}

@DriftAccessor(tables: <Type>[Users])
class UsersDao extends DatabaseAccessor<Database> with _$UsersDaoMixin {
  UsersDao(super.db);

  Future<UserEntity> createUser(AccountEntity account) async => into(users)
      .insertReturning(UsersCompanion.insert(id: DBValue(account.id), createdAt: clock.now()))
      .then(_mapUserDataModel);

  Future<UserEntity?> getSingleUser(String id) async =>
      (select(users)..where((_) => _.id.equals(id))).map(_mapUserDataModel).getSingleOrNull();

  UserEntity _mapUserDataModel(UserDataModel user) => user.toEntity(users.actualTableName);
}

@DriftAccessor(tables: <Type>[Budgets])
class BudgetsDao extends DatabaseAccessor<Database> with _$BudgetsDaoMixin {
  BudgetsDao(super.db);

  Stream<BudgetEntity?> watchActiveBudget() => (select(budgets)
        ..where((_) => _.active.equals(true))
        ..limit(1))
      .map((_) => _.toEntity(budgets.actualTableName))
      .watchSingleOrNull();

  Stream<BudgetEntity> watchSingleBudget(String id) => (select(budgets)
        ..where((_) => _.id.equals(id))
        ..limit(1))
      .map((_) => _.toEntity(budgets.actualTableName))
      .watchSingle();

  Stream<BudgetEntityList> watchAllBudgets() => select(budgets).map((_) => _.toEntity(budgets.actualTableName)).watch();

  Future<bool> deleteBudget(String id) async => (delete(budgets)..where((_) => _.id.equals(id))).go().then((_) => true);

  Future<bool> activateBudget(String id) async => (update(budgets)..where((_) => _.id.equals(id)))
      .write(
        BudgetsCompanion(
          active: const DBValue(true),
          updatedAt: DBValue(clock.now()),
        ),
      )
      .then((_) => true);

  Future<bool> deactivateBudget(String id, DateTime? endedAt) async => (update(budgets)..where((_) => _.id.equals(id)))
      .write(
        BudgetsCompanion(
          active: const DBValue(false),
          endedAt: endedAt != null ? DBValue(endedAt) : const DBValue.absent(),
          updatedAt: DBValue(clock.now()),
        ),
      )
      .then((_) => true);

  Future<bool> updateBudget(UpdateBudgetData budget) async => (update(budgets)..where((_) => _.id.equals(budget.id)))
      .write(
        BudgetsCompanion(
          title: DBValue(budget.title),
          description: DBValue(budget.description),
          amount: DBValue(budget.amount),
          active: DBValue(budget.active),
          startedAt: DBValue(budget.startedAt),
          endedAt: DBValue(budget.endedAt),
          updatedAt: DBValue(clock.now()),
        ),
      )
      .then((_) => true);

  Future<BudgetEntity> createBudget(CreateBudgetData budget) async => into(budgets)
      .insertReturning(
        BudgetsCompanion.insert(
          index: budget.index,
          title: budget.title,
          amount: budget.amount,
          description: budget.description,
          active: budget.active,
          startedAt: budget.startedAt,
          endedAt: DBValue(budget.endedAt),
          createdAt: clock.now(),
        ),
      )
      .then((_) => _.toEntity(budgets.actualTableName));
}

@DriftAccessor(tables: <Type>[BudgetPlans, BudgetCategories])
class BudgetPlansDao extends DatabaseAccessor<Database> with _$BudgetPlansDaoMixin {
  BudgetPlansDao(super.db);

  Stream<BudgetPlanEntity> watchSingleBudgetPlan(String id) => (select(budgetPlans)..where((_) => _.id.equals(id)))
      .join(<DBJoin>[
        innerJoin(budgetCategories, budgetCategories.id.equalsExp(budgetPlans.category)),
      ])
      .map(_mapRowToEntity)
      .watchSingle();

  Stream<BudgetPlanEntityList> watchAllBudgetPlans() => select(budgetPlans)
      .join(<DBJoin>[
        innerJoin(budgetCategories, budgetCategories.id.equalsExp(budgetPlans.category)),
      ])
      .map(_mapRowToEntity)
      .watch();

  Stream<BudgetPlanEntityList> watchAllBudgetPlansByCategory(String id) =>
      (select(budgetPlans)..where((_) => _.category.equals(id)))
          .join(<DBJoin>[
            innerJoin(budgetCategories, budgetCategories.id.equalsExp(budgetPlans.category)),
          ])
          .map(_mapRowToEntity)
          .watch();

  Future<bool> deletePlan(String id) async =>
      (delete(budgetPlans)..where((_) => _.id.equals(id))).go().then((_) => true);

  Future<bool> updatePlan(UpdateBudgetPlanData plan) async => (update(budgetPlans)..where((_) => _.id.equals(plan.id)))
      .write(
        BudgetPlansCompanion(
          title: DBValue(plan.title),
          description: DBValue(plan.description),
          category: DBValue(plan.category.id),
          updatedAt: DBValue(clock.now()),
        ),
      )
      .then((_) => true);

  Future<String> createPlan(CreateBudgetPlanData plan) async => into(budgetPlans)
      .insertReturning(
        BudgetPlansCompanion.insert(
          title: plan.title,
          description: plan.description,
          category: plan.category.id,
          createdAt: clock.now(),
        ),
      )
      .then((_) => _.id);

  BudgetPlanEntity _mapRowToEntity(TypedResult row) {
    final BudgetPlanDataModel plan = row.readTable(budgetPlans);
    final BudgetCategoryDataModel category = row.readTable(budgetCategories);

    return plan.toEntity(
      tableName: budgetPlans.actualTableName,
      category: (budgetCategories.actualTableName, category),
    );
  }
}

@DriftAccessor(tables: <Type>[BudgetCategories])
class BudgetCategoriesDao extends DatabaseAccessor<Database> with _$BudgetCategoriesDaoMixin {
  BudgetCategoriesDao(super.db);

  Stream<BudgetCategoryEntityList> watchAllBudgetCategories() =>
      select(budgetCategories).map((_) => _.toEntity(budgetCategories.actualTableName)).watch();

  Future<bool> deleteCategory(String id) async =>
      (delete(budgetCategories)..where((_) => _.id.equals(id))).go().then((_) => true);

  Future<bool> updateCategory(UpdateBudgetCategoryData category) async =>
      (update(budgetCategories)..where((_) => _.id.equals(category.id)))
          .write(
            BudgetCategoriesCompanion(
              title: DBValue(category.title),
              description: DBValue(category.description),
              iconIndex: DBValue(category.iconIndex),
              colorSchemeIndex: DBValue(category.colorSchemeIndex),
              updatedAt: DBValue(clock.now()),
            ),
          )
          .then((_) => true);

  Future<BudgetCategoryEntity> createCategory(CreateBudgetCategoryData category) async => into(budgetCategories)
      .insertReturning(
        BudgetCategoriesCompanion.insert(
          title: category.title,
          description: category.description,
          iconIndex: category.iconIndex,
          colorSchemeIndex: category.colorSchemeIndex,
          createdAt: clock.now(),
        ),
      )
      .then((_) => _.toEntity(budgetCategories.actualTableName));
}

@DriftAccessor(tables: <Type>[Budgets, BudgetPlans, BudgetCategories, BudgetAllocations])
class BudgetAllocationsDao extends DatabaseAccessor<Database> with _$BudgetAllocationsDaoMixin {
  BudgetAllocationsDao(super.db);

  Stream<BudgetAllocationEntity> watchSingleBudgetPlan({
    required String budgetId,
    required String planId,
  }) =>
      (select(budgetAllocations)..where((_) => _.budget.equals(budgetId) & _.plan.equals(planId)))
          .join(<DBJoin>[
            innerJoin(budgets, budgets.id.equalsExp(budgetAllocations.budget)),
            innerJoin(budgetPlans, budgetPlans.id.equalsExp(budgetAllocations.plan)),
          ])
          .watchSingle()
          .switchMap((TypedResult row) {
            final BudgetPlanDataModel plan = row.readTable(budgetPlans);
            return (select(budgetCategories)..where((_) => _.id.equals(plan.id))).watchSingle().map(
                  (BudgetCategoryDataModel category) => _mapRowToEntity(
                    row,
                    <String, BudgetCategoryDataModel>{
                      category.id: category,
                    },
                  ),
                );
          });

  Stream<BudgetAllocationEntityList> watchAllBudgetAllocations() => _selectAll(select(budgetAllocations));

  Stream<BudgetAllocationEntityList> watchAllBudgetAllocationsByBudget(String id) =>
      _selectAll(select(budgetAllocations)..where((_) => _.budget.equals(id)));

  Stream<BudgetAllocationEntityList> watchAllBudgetAllocationsByPlan(String id) =>
      _selectAll(select(budgetAllocations)..where((_) => _.plan.equals(id)));

  Future<bool> deleteAllocation(String id) async =>
      (delete(budgetAllocations)..where((_) => _.id.equals(id))).go().then((_) => true);

  Future<bool> deleteAllocationByPlan(String id) async =>
      (delete(budgetAllocations)..where((_) => _.plan.equals(id))).go().then((_) => true);

  Future<bool> updateAllocation(UpdateBudgetAllocationData allocation) async =>
      (update(budgetAllocations)..where((_) => _.id.equals(allocation.id)))
          .write(
            BudgetAllocationsCompanion(
              amount: DBValue(allocation.amount),
            ),
          )
          .then((_) => true);

  Future<bool> createAllocations(List<CreateBudgetAllocationData> allocations) async =>
      budgetAllocations.insertAll(allocations.map(_mapToInsertData)).then((_) => true);

  Future<String> createAllocation(CreateBudgetAllocationData allocation) async =>
      into(budgetAllocations).insertReturning(_mapToInsertData(allocation)).then((_) => _.id);

  Stream<BudgetAllocationEntityList> _selectAll(SimpleSelectStatement<$BudgetAllocationsTable, Object?> query) => query
      .join(<DBJoin>[
        innerJoin(budgets, budgets.id.equalsExp(budgetAllocations.budget)),
        innerJoin(budgetPlans, budgetPlans.id.equalsExp(budgetAllocations.plan)),
      ])
      .watch()
      .switchMap(_mapToEntityListStream);

  Stream<BudgetAllocationEntityList> _mapToEntityListStream(List<TypedResult> rows) =>
      select(budgetCategories).watch().map((_) {
        final Map<String, BudgetCategoryDataModel> categoryById = _.foldToMap((_) => _.id);

        return rows.map((_) => _mapRowToEntity(_, categoryById)).toList(growable: false);
      });

  BudgetAllocationEntity _mapRowToEntity(TypedResult row, Map<String, BudgetCategoryDataModel> categoryById) {
    final BudgetAllocationDataModel allocation = row.readTable(budgetAllocations);
    final BudgetDataModel budget = row.readTable(budgets);
    final BudgetPlanDataModel plan = row.readTable(budgetPlans);

    return allocation.toEntity(
      tableName: budgetAllocations.actualTableName,
      budget: (budgets.actualTableName, budget),
      plan: (budgetPlans.actualTableName, plan),
      category: (budgetCategories.actualTableName, categoryById[plan.category]!),
    );
  }

  Insertable<BudgetAllocationDataModel> _mapToInsertData(CreateBudgetAllocationData allocation) {
    return BudgetAllocationsCompanion.insert(
      amount: allocation.amount,
      budget: allocation.budget.id,
      plan: allocation.plan.id,
      createdAt: clock.now(),
    );
  }
}
