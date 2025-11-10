import 'package:ovavue/presentation/screens/budgets/providers/active_budget_id_provider.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_budget_provider.g.dart';

@Riverpod(dependencies: <Object>[activeBudgetId, selectedBudget])
Stream<BaseBudgetState> activeBudget(Ref ref) async* {
  final budgetId = await ref.watch(activeBudgetIdProvider.future);

  if (budgetId == null) {
    yield BaseBudgetState.empty;
  } else {
    yield await ref.watch(selectedBudgetProvider(budgetId).future);
  }
}
