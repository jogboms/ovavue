import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:ovavue/presentation/state/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_plans_provider.g.dart';

@Riverpod(dependencies: [registry, user])
Stream<List<BudgetPlanViewModel>> budgetPlans(Ref ref) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetPlansUseCase>()
      .call(user.id)
      .map((BudgetPlanEntityList e) => e.map(BudgetPlanViewModel.fromEntity).toList(growable: false));
}
