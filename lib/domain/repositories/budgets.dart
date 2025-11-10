import 'package:ovavue/domain/entities/budget_entity.dart';
import 'package:ovavue/domain/entities/create_budget_data.dart';
import 'package:ovavue/domain/entities/reference_entity.dart';
import 'package:ovavue/domain/entities/update_budget_data.dart';

abstract class BudgetsRepository {
  Future<ReferenceEntity> create(String userId, CreateBudgetData budget);

  Future<bool> update(UpdateBudgetData budget);

  Future<bool> delete(ReferenceEntity reference);

  Stream<BudgetEntityList> fetchAll(String userId);

  Stream<BudgetEntity?> fetchActiveBudget(String userId);

  Future<bool> activateBudget(ReferenceEntity reference);

  Future<bool> deactivateBudget({
    required ReferenceEntity reference,
    required DateTime? endedAt,
  });

  Stream<BudgetEntity> fetchOne({
    required String userId,
    required String budgetId,
  });
}
