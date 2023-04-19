import 'package:collection/collection.dart';
import 'package:ovavue/domain.dart';
import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models.dart';
import '../state.dart';

part 'budgets_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetViewModel>> budgets(BudgetsRef ref) async* {
  final Registry registry = ref.read(registryProvider);
  final UserEntity user = await ref.watch(userProvider.future);

  yield* registry.get<FetchBudgetsUseCase>().call(user.id).map(
        (NormalizedBudgetEntityList budgets) => budgets
            .map(BudgetViewModel.fromEntity)
            .sorted((BudgetViewModel a, BudgetViewModel b) => b.startedAt.compareTo(a.startedAt))
            .toList(growable: false),
      );
}
