import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUsersRepository extends Mock implements UsersRepository {}

class MockBudgetsRepository extends Mock implements BudgetsRepository {}

class MockBudgetPlansRepository extends Mock implements BudgetPlansRepository {}

class MockBudgetCategoriesRepository extends Mock implements BudgetCategoriesRepository {}

class MockBudgetAllocationsRepository extends Mock implements BudgetAllocationsRepository {}

class MockCreateBudgetAllocationUseCase extends Mock implements CreateBudgetAllocationUseCase {}

class MockCreateBudgetCategoryUseCase extends Mock implements CreateBudgetCategoryUseCase {}

class MockCreateBudgetPlanUseCase extends Mock implements CreateBudgetPlanUseCase {}

class MockCreateBudgetUseCase extends Mock implements CreateBudgetUseCase {}

class MockCreateUserUseCase extends Mock implements CreateUserUseCase {}

class MockDeleteBudgetAllocationUseCase extends Mock implements DeleteBudgetAllocationUseCase {}

class MockDeleteBudgetCategoryUseCase extends Mock implements DeleteBudgetCategoryUseCase {}

class MockDeleteBudgetPlanUseCase extends Mock implements DeleteBudgetPlanUseCase {}

class MockDeleteBudgetUseCase extends Mock implements DeleteBudgetUseCase {}

class MockFetchAccountUseCase extends Mock implements FetchAccountUseCase {}

class MockFetchBudgetAllocationUseCase extends Mock implements FetchBudgetAllocationUseCase {}

class MockFetchBudgetAllocationsUseCase extends Mock implements FetchBudgetAllocationsUseCase {}

class MockFetchBudgetAllocationsByPlanUseCase extends Mock implements FetchBudgetAllocationsByPlanUseCase {}

class MockFetchBudgetCategoriesUseCase extends Mock implements FetchBudgetCategoriesUseCase {}

class MockFetchBudgetPlansUseCase extends Mock implements FetchBudgetPlansUseCase {}

class MockFetchBudgetPlansByCategoryUseCase extends Mock implements FetchBudgetPlansByCategoryUseCase {}

class MockFetchBudgetsUseCase extends Mock implements FetchBudgetsUseCase {}

class MockFetchActiveBudgetUseCase extends Mock implements FetchActiveBudgetUseCase {}

class MockFetchUserUseCase extends Mock implements FetchUserUseCase {}

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockUpdateUserUseCase extends Mock implements UpdateUserUseCase {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockValueChangedCallback<T> extends Mock {
  void call(T data);
}

class MockAsyncCallback<T> extends Mock {
  Future<T> call();
}

class FakeRoute extends Fake implements Route<dynamic> {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeFlutterErrorDetails extends Fake implements FlutterErrorDetails {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return toDiagnosticsNode(style: DiagnosticsTreeStyle.error).toStringDeep(minLevel: minLevel);
  }
}
