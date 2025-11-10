import 'package:collection/collection.dart';
import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budgets_provider.g.dart';

@Riverpod(dependencies: <Object>[registry, user])
Stream<List<BudgetViewModel>> budgets(BudgetsRef ref) async* {
  final registry = ref.read(registryProvider);
  final user = await ref.watch(userProvider.future);

  yield* registry
      .get<FetchBudgetsUseCase>()
      .call(user.id)
      .map(
        (BudgetEntityList budgets) => budgets
            .map(BudgetViewModel.fromEntity)
            .sorted((BudgetViewModel a, BudgetViewModel b) => b.startedAt.compareTo(a.startedAt))
            .toList(growable: false),
      );
}
