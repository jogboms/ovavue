import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models.dart';
import 'registry_provider.dart';
import 'user_provider.dart';

part 'budget_plans_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetPlanViewModel>> budgetPlans(BudgetPlansRef ref) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetPlansUseCase>()
      .call(user.id)
      .map((_) => _.map(BudgetPlanViewModel.fromEntity).toList(growable: false));
}
