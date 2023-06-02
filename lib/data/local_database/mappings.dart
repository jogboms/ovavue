part of 'database.dart';

extension AccountEntityExtension on AccountDataModel {
  AccountEntity toEntity() => AccountEntity(id: id);
}

extension UserEntityExtension on UserDataModel {
  UserEntity toEntity(String tableName) => UserEntity(id: id, path: '$tableName/$id', createdAt: createdAt);
}

extension BudgetEntityExtension on BudgetDataModel {
  BudgetEntity toEntity(String tableName) {
    return BudgetEntity(
      id: id,
      path: '/$tableName/$id',
      index: index,
      title: title,
      amount: amount,
      description: description,
      active: active,
      startedAt: startedAt,
      endedAt: endedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetPlanEntityExtension on BudgetPlanDataModel {
  BudgetPlanEntity toEntity({
    required String tableName,
    required TableNameModelPair<BudgetCategoryDataModel> category,
  }) {
    return BudgetPlanEntity(
      id: id,
      path: '/$tableName/$id',
      title: title,
      description: description,
      category: category.$2.toEntity(category.$1),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetCategoryEntityExtension on BudgetCategoryDataModel {
  BudgetCategoryEntity toEntity(String tableName) {
    return BudgetCategoryEntity(
      id: id,
      path: '/$tableName/$id',
      title: title,
      description: description,
      iconIndex: iconIndex,
      colorSchemeIndex: colorSchemeIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetAllocationEntityExtension on BudgetAllocationDataModel {
  BudgetAllocationEntity toEntity({
    required String tableName,
    required TableNameModelPair<BudgetDataModel> budget,
    required TableNameModelPair<BudgetPlanDataModel> plan,
    required TableNameModelPair<BudgetCategoryDataModel> category,
  }) {
    return BudgetAllocationEntity(
      id: id,
      path: '/$tableName/$id',
      amount: amount,
      budget: budget.$2.toEntity(budget.$1),
      plan: plan.$2.toEntity(tableName: plan.$1, category: category),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetMetadataKeyEntityExtension on BudgetMetadataKeyDataModel {
  BudgetMetadataKeyEntity toEntity(String tableName) {
    return BudgetMetadataKeyEntity(
      id: id,
      path: '/$tableName/$id',
      title: title,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetMetadataValueEntityExtension on BudgetMetadataValueDataModel {
  BudgetMetadataValueEntity toEntity({
    required String tableName,
    required TableNameModelPair<BudgetMetadataKeyDataModel> key,
  }) {
    return BudgetMetadataValueEntity(
      id: id,
      path: '/$tableName/$id',
      title: title,
      value: value,
      key: key.$2.toEntity(key.$1),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BudgetPlanReferenceEntityExtension on BudgetMetadataAssociationDataModel {
  ReferenceEntity toPlanReferenceEntity(String tableName) => (id: plan, path: '/$tableName/$id');
}

typedef TableNameModelPair<T> = (String, T);
